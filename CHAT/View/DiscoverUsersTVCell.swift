//
//  DiscoverUsersTVCell.swift
//  CHAT
//
//  Created by 文戊 on 2018/9/14.
//  Copyright © 2018年 黑泡唱片. All rights reserved.
//

import UIKit

class DiscoverUsersTVCell: UITableViewCell {
    
    @IBOutlet weak var 用户头像: UIImageView!
    @IBOutlet weak var 用户名称: UILabel!
    @IBOutlet weak var 关注按钮: UIButton!
    
    
    var 用户: 用户Model? {
        didSet {
            setupUserInfo()
        }
    }
    
    func setupUserInfo() {
        用户名称.text = 用户?.用户名称
        if let 用户头像UrlString = 用户?.用户头像Url {
            let 图片Url = URL(string: 用户头像UrlString)
            self.用户头像.sd_setImage(with: 图片Url, placeholderImage:UIImage(named: "default-user-avatar"))
        }
        if 用户!.正在关注!{
            配置取消关注按钮()
        } else {
            配置关注按钮()
        }
    }
    
    func 配置关注按钮() {
        样式管理.正在关注按钮样式(layer: 关注按钮)
        关注按钮.addTarget(self, action: #selector(self.关注动作), for: UIControlEvents.touchUpInside)
    }
    
    func 配置取消关注按钮() {
        样式管理.取消关注按钮样式(layer: 关注按钮)
        关注按钮.addTarget(self, action: #selector(self.取消关注动作), for: UIControlEvents.touchUpInside)
    }
    
    @objc func 关注动作() {
        if 用户!.正在关注! == false{
            数据库地址.关注地址.关注动作(withUser: 用户!.用户ID!)
            配置取消关注按钮()
            用户!.正在关注! = true
        }

    }
    
    @objc func 取消关注动作() {
        if 用户!.正在关注! == true{
            数据库地址.关注地址.取消关注动作(withUser: 用户!.用户ID!)
            配置关注按钮()
            用户!.正在关注! = false
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        用户名称.text = ""
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
