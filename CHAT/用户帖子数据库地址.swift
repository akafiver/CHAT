//
//  用户帖子数据库地址.swift
//  CHAT
//
//  Created by 文戊 on 2018/9/13.
//  Copyright © 2018年 黑泡唱片. All rights reserved.
//

import Foundation
import FirebaseDatabase
class 用户帖子数据库地址 {
    var 用户帖子引用地址 = Database.database().reference().child("myPosts")
}
