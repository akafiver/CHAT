//
//  PorfileUserCardCRV.swift
//  CHAT
//
//  Created by 文戊 on 2018/9/13.
//  Copyright © 2018年 黑泡唱片. All rights reserved.
//

import UIKit

class UserPorfileCardCRV: UICollectionReusableView {
    
    @IBOutlet weak var 用户头像: UIImageView!
    @IBOutlet weak var 用户名称: UILabel!
    @IBOutlet weak var 用户简介: UILabel!

    var 用户: 用户Model? {
        didSet {
            设置用户卡片资料()
        }
    }
    
    
    func 设置用户卡片资料(){
        数据库地址.用户地址.当前用户总览 { (单个用户) in
            self.用户名称.text=单个用户.用户名称
            if let 用户头像UrlString = 单个用户.用户头像Url {
                let 图片Url = URL(string: 用户头像UrlString)
                self.用户头像.sd_setImage(with: 图片Url, placeholderImage:UIImage(named: "default-user-avatar"))
            }
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
    
    
}
