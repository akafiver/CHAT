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
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight=460
        tableView.rowHeight=UITableViewAutomaticDimension
        tableView.dataSource=self
        loadPosts()
    }

    
    func loadPosts(){
        Database.database().reference().child("posts").observe(.childAdded) { (snapshot:DataSnapshot) in
            if let snapshotValue = snapshot.value as? [String:Any]{
            let text = snapshotValue["text"] as! String
            let url = snapshotValue["photoUrl"] as! String
//            let uid = snapshotValue["userID"] as! String
            let post = Post(feedText: text, imageUrl: url)
            self.postArray.append(post)
            self.tableView.reloadData()
            }
        }
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
        cell.updateCellView(post: post)
//        cell.textLabel?.text=postArray[indexPath.row].text
//        样式管理.头像样式(layer: cell.userAvatarV)
//        样式管理.图片样式(layer: cell.feedImgV)
        return cell
    }
}
