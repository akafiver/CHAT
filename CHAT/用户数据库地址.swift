//
//  用户数据库地址.swift
//  CHAT
//
//  Created by 文戊 on 2018/9/12.
//  Copyright © 2018年 黑泡唱片. All rights reserved.
//

import Foundation
import FirebaseDatabase
class 用户数据库地址 {
    var 帖子引用地址 = Database.database().reference().child("users")
    
    func 用户总览(withId uid: String, completion: @escaping (用户Model) -> Void) {
        帖子引用地址.child("profile").child(uid).observeSingleEvent(of: DataEventType.value, with: {
            快照 in
            if let 快照值 = 快照.value as? [String:Any]{
                let 单个用户 = 用户Model.用户转换值(字典: 快照值)
                completion(单个用户)
            }
        })
    }
}
