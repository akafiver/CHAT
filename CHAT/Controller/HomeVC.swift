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
        数据库地址.Feed地址.Feed总览(withId: 数据库地址.用户地址.当前用户!.uid) { (帖子) in
            guard let 帖子Id = 帖子.uid else {
                return
            }
            self.读取用户(uid: 帖子Id, completed: {
                self.帖子Array.append(帖子)
                self.loadingAnimat.stopAnimating()
                self.tableView.reloadData()
            })
        }
        
        数据库地址.Feed地址.Feed移除总览(withId: 数据库地址.用户地址.当前用户!.uid) { (key) in
            self.帖子Array = self.帖子Array.filter { $0.帖子id != key }
            self.tableView.reloadData()
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
    
//    func numberOfSections(in tableView: UITableView) -> Int{
//        var numOfSections: Int = 0
//        if 帖子Array.count > 0{
//            numOfSections            = 1
//            tableView.backgroundView = nil
//        }else{
//            let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
//            noDataLabel.text          = "No data available"
//            noDataLabel.textColor     = UIColor.black
//            noDataLabel.textAlignment = .center
//            tableView.backgroundView  = noDataLabel
//            tableView.separatorStyle  = .none
//        }
//        return numOfSections
//    }
}
