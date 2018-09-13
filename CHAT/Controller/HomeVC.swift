//
//  HomeVC.swift
//  CHAT
//
//  Created by 文戊 on 2018/9/8.
//  Copyright © 2018年 黑泡唱片. All rights reserved.
//

import UIKit
import SDWebImage

class HomeVC: UIViewController,UITableViewDelegate {

    var 帖子Array=[帖子Model]()
    var 用户Array=[用户Model]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingAnimat: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight=490
        tableView.rowHeight=UITableViewAutomaticDimension
        tableView.dataSource=self
        加载帖子()
    }

    
    func 加载帖子(){
        loadingAnimat.startAnimating()
        数据库地址.帖子地址.帖子总览 { (新帖子) in
            self.读取用户(uid: 新帖子.uid!, completed: {
                self.帖子Array.append(新帖子)
                self.loadingAnimat.stopAnimating()
                self.tableView.reloadData()
            })
        }
    }
    
    func 读取用户(uid:String, completed:  @escaping () -> Void ) {
        数据库地址.用户地址.用户总览(withId: uid) { (单个用户) in
            self.用户Array.append(单个用户)
            completed()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    //设置评论页面回路至帖子ID
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCommentsPage" {
            let 评论页面 = segue.destination as! CommentsVC
            let 帖子Id = sender  as! String
            评论页面.帖子Id = 帖子Id
        }
    }


}

extension HomeVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 帖子Array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! HomeFeedableViewCell
        
//        cell.帖子图片.layer.cornerRadius = 15
//        cell.帖子图片.layer.masksToBounds = false
//        let 图片=cell.帖子图片!
//        let shadowPath2 = UIBezierPath(rect: cell.bounds)
//        图片.layer.shadowColor = UIColor.black.cgColor
//        图片.layer.shadowOffset = CGSize(width: 0, height: 6.0)
//        图片.layer.shadowOpacity = 0.3
//        图片.layer.shadowRadius=30
//        图片.layer.shadowPath = shadowPath2.cgPath
        cell.contentView.layer.shadowColor = UIColor.black.cgColor
        cell.contentView.layer.shadowOffset = CGSize(width: 0, height: 5.0)
        cell.contentView.layer.shadowOpacity = 0.3
        cell.contentView.layer.shadowRadius=17
        
        
        let 帖子集合=帖子Array[indexPath.row]
        let 用户集合=用户Array[indexPath.row]
        cell.帖子=帖子集合
        cell.用户=用户集合
        cell.homeVC = self
//        cell.textLabel?.text=postArray[indexPath.row].text
//        样式管理.头像样式(layer: cell.userAvatarV)
//        样式管理.图片样式(layer: cell.feedImgV)
        return cell
    }
}
