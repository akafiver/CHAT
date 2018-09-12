//
//  帖子评论数据库地址.swift
//  CHAT
//
//  Created by 文戊 on 2018/9/12.
//  Copyright © 2018年 黑泡唱片. All rights reserved.
//

import Foundation
import FirebaseDatabase
class 帖子评论数据库地址 {
    var 帖子评论引用地址 = Database.database().reference().child("post-comments")
}
