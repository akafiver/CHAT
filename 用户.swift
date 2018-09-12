//
//  User.swift
//  InstagramClone
//
//  Created by The Zero2Launch Team on 12/30/16.
//  Copyright © 2016 The Zero2Launch Team. All rights reserved.
//

import Foundation
class 用户Model {
    var 电子邮件: String?
    var 用户头像Url: String?
    var 用户名称: String?
    
//    init(name:String,AvatarImageUrl:String,mail:String){
//        userName=name
//        userAvatarImageUrl=AvatarImageUrl
//        email=mail
//    }
}

//红字内为上传至数据库的分类名称
extension 用户Model {
    static func 用户转换值(字典: [String: Any]) -> 用户Model {
        let 用户 = 用户Model()
        用户.电子邮件 = 字典["email"] as? String
        用户.用户头像Url = 字典["userAvatarImageUrl"] as? String
        用户.用户名称 = 字典["userName"] as? String

        return 用户
    }
}
