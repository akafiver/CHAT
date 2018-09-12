//
//  HomeVC.swift
//  CHAT
//
//  Created by 文戊 on 2018/9/8.
//  Copyright © 2018年 黑泡唱片. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class HomeVC: UIViewController,UITableViewDelegate {

    var 帖子Array=[Post]()
    var 用户Array=[User]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingAnimat: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight=460
        tableView.rowHeight=UITableViewAutomaticDimension
        tableView.dataSource=self
        加载帖子()
    }

    
    func 加载帖子(){
        loadingAnimat.startAnimating()
        Database.database().reference().child("posts").observe(.childAdded) { (快照:DataSnapshot) in
            if let 快照值 = 快照.value as? [String:Any]{
                let 新帖子=Post.帖子照片转换值(dict: 快照值,key:快照.key)
                self.读取用户(uid: 新帖子.uid!, completed: {
                self.帖子Array.append(新帖子)
                self.loadingAnimat.stopAnimating()
                self.tableView.reloadData()
                })
            }
        }
    }
    
    func 读取用户(uid:String, completed:  @escaping () -> Void ) {
        Database.database().reference().child("users").child("profile").child(uid).observeSingleEvent(of: DataEventType.value, with: {
            snapshot in
            if let snapshotValue = snapshot.value as? [String:Any]{
                let user = User.transformUser(dict: snapshotValue)
                self.用户Array.append(user)
                completed()
                }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

extension HomeVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 帖子Array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! HomeFeedableViewCell
        let post=帖子Array[indexPath.row]
        let user=用户Array[indexPath.row]
        cell.post=post
        cell.user=user
        cell.homeVC = self
//        cell.textLabel?.text=postArray[indexPath.row].text
//        样式管理.头像样式(layer: cell.userAvatarV)
//        样式管理.图片样式(layer: cell.feedImgV)
        return cell
    }
}
