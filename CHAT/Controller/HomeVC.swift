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

    var postArray=[Post]()
    var usersArray=[User]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingAnimat: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight=460
        tableView.rowHeight=UITableViewAutomaticDimension
        tableView.dataSource=self
        loadPosts()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden=false
    }

    @IBAction func buttonToComments(_ sender: Any) {
        performSegue(withIdentifier: "toCommentsPage", sender: nil)
    }
    
    func loadPosts(){
        loadingAnimat.startAnimating()
        Database.database().reference().child("posts").observe(.childAdded) { (snapshot:DataSnapshot) in
            if let snapshotValue = snapshot.value as? [String:Any]{
                let 新帖子=Post.PostPhoto转换值(dict: snapshotValue)
                self.user读取(uid: 新帖子.uid!, completed: {
                self.postArray.append(新帖子)
                self.loadingAnimat.stopAnimating()
                self.tableView.reloadData()
                })
            }
        }
    }
    
    func user读取(uid:String, completed:  @escaping () -> Void ) {
        Database.database().reference().child("users").child("profile").child(uid).observeSingleEvent(of: DataEventType.value, with: {
            snapshot in
            if let snapshotValue = snapshot.value as? [String:Any]{
                let user = User.transformUser(dict: snapshotValue)
                self.usersArray.append(user)
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
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! HomeFeedableViewCell
        let post=postArray[indexPath.row]
        let user=usersArray[indexPath.row]
        cell.post=post
        cell.user=user
//        cell.textLabel?.text=postArray[indexPath.row].text
//        样式管理.头像样式(layer: cell.userAvatarV)
//        样式管理.图片样式(layer: cell.feedImgV)
        return cell
    }
}
