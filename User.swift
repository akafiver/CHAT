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
    var profileImageUrl: String?
    var username: String?
}

extension User {
    static func transformUser(dict: [String: Any]) -> User {
        let user = User()
        user.email = dict["email"] as? String
        user.profileImageUrl = dict["profileImageUrl"] as? String
        user.username = dict["username"] as? String
        
        return user
    }
}
