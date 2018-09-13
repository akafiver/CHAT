//
//  HomeFeedableViewCell.swift
//  CHAT
//
//  Created by 文戊 on 2018/9/10.
//  Copyright © 2018年 黑泡唱片. All rights reserved.
//

import UIKit
import SVProgressHUD

class HomeFeedableViewCell: UITableViewCell {

    @IBOutlet weak var 帖子图片: UIImageView!
    @IBOutlet weak var 用户头像: UIImageView!
    @IBOutlet weak var 用户名称: UILabel!
    @IBOutlet weak var 帖子文字内容: UILabel!
    @IBOutlet weak var 获赞数量: UILabel!
    @IBOutlet weak var 评论数量: UILabel!
    @IBOutlet weak var 获赞图标: UIButton!
    
    var homeVC:HomeVC?
    
    var 帖子:帖子Model? {
        didSet {
            更新Cell内容()
        }
    }
    var 用户:用户Model? {
        didSet {
            设置帖子用户资料()
        }
    }
    func 加载阴影(){
        样式管理.图片样式(layer: 帖子图片)
    }
    func 更新Cell内容(){
        //更新帖子图片和文字内容
        帖子文字内容.text=帖子?.帖子文字内容
        let 图片UrlString = 帖子?.帖子图片URL
        let 图片Url = URL(string: 图片UrlString!)
        self.帖子图片.sd_setImage(with: 图片Url, completed: { [weak self] (image, error, cacheType, imageURL) in
            self?.帖子图片.image = image })
        //提取帖子唯一ID
        数据库地址.帖子地址.帖子引用地址.child(self.帖子!.帖子id!).observeSingleEvent(of: .value, with: { (快照) in
            if let 字典 = 快照.value as? [String: Any] {
                let 帖子 = 帖子Model.帖子照片转换值(字典: 字典, 帖子辨识码: 快照.key)
                self.更新赞(帖子值: 帖子)}
        })
        //根据帖子唯一ID提取帖子获赞数量
        数据库地址.帖子地址.帖子引用地址.child((帖子!.帖子id)!).observe(.childChanged, with: {快照 in
            if let 值 = 快照.value as? Int {self.获赞数量.text="\(值) 赞"}
        })
        

    }
    
    func 设置帖子用户资料(){
        用户名称.text=用户?.用户名称
        if let 用户头像UrlString = 用户?.用户头像Url {
            let 图片Url = URL(string: 用户头像UrlString)
            self.用户头像.sd_setImage(with: 图片Url, placeholderImage:UIImage(named: "default-user-avatar"))
        }
    }
    
    
    @IBAction func commentButtonInCell(_ sender: Any) {
        if let id = 帖子?.帖子id {homeVC?.performSegue(withIdentifier: "toCommentsPage", sender: id)}
    }
    @IBAction func likebutton(_ sender: Any) {
        数据库地址.帖子地址.增量Likes(帖子Id: (帖子?.帖子id)!, onSucess: { (帖子Model) in
            self.更新赞(帖子值: 帖子Model)
        }) { (error) in
            SVProgressHUD.showError(withStatus: error)
        }
        

    }
    
    func 更新赞(帖子值: 帖子Model) {
        let 图片名字 = 帖子值.所有赞 == nil || !帖子值.赞了! ? "LikeButton" : "LikeButtonClick"
        获赞图标.setImage(UIImage(named:图片名字), for: UIControlState.normal)
        guard let 计数 = 帖子值.赞计数 else {
            return }
        if 计数 != 0 { 获赞数量.text="\(计数) 赞" } else { 获赞数量.text="" }
    }
    

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        用户名称.text = ""
        帖子文字内容.text = ""
        获赞图标.setImage(UIImage(named:"LikeButton"), for: UIControlState.normal)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        用户头像.image=UIImage(named: "default-user-avatar")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}







//        数据库地址.用户地址.帖子引用地址.child("profile").child((Auth.auth().currentUser?.uid)!).child("like").child(帖子!.帖子id!).observeSingleEvent(of: .value, with: {
//            snapshot in
//            print(snapshot)
//            if let _ = snapshot.value as? NSNull {
//                self.获赞图标.setImage(UIImage(named:"LikeButton"), for: UIControlState.normal)
//
//            } else {
//                self.获赞图标.setImage(UIImage(named: "LikeButtonClick"), for: UIControlState.normal)
//
//            }
//        })




//        数据库地址.用户地址.帖子引用地址.child("profile").child((Auth.auth().currentUser?.uid)!).child("like").child(帖子!.帖子id!).observeSingleEvent(of: .value, with: {
//            snapshot in
//            if let _ = snapshot.value as? NSNull {
//                数据库地址.用户地址.帖子引用地址.child("profile").child((Auth.auth().currentUser?.uid)!).child("like").child(self.帖子!.帖子id!).setValue(true)
//                self.获赞图标.setImage(UIImage(named:"LikeButtonClick"), for: UIControlState.normal)
//
//            } else {
//                数据库地址.用户地址.帖子引用地址.child("profile").child((Auth.auth().currentUser?.uid)!).child("like").child(self.帖子!.帖子id!).removeValue()
//                self.获赞图标.setImage(UIImage(named: "LikeButton"), for: UIControlState.normal)
//            }
//        })
