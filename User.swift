//
//  User.swift
//  InstagramClone
//
//  Created by The Zero2Launch Team on 12/30/16.
//  Copyright © 2016 The Zero2Launch Team. All rights reserved.
//

import Foundation
class User {
    var email: String?
    var userAvatarImageUrl: String?
    var userName: String?
    
//    init(name:String,AvatarImageUrl:String,mail:String){
//        userName=name
//        userAvatarImageUrl=AvatarImageUrl
//        email=mail
//    }
}


extension User {
    static func transformUser(dict: [String: Any]) -> User {
        let user = User()
        user.email = dict["email"] as? String
        user.userAvatarImageUrl = dict["userAvatarImageUrl"] as? String
        user.userName = dict["userName"] as? String

        return user
    }
}
