//
//  评论数据库地址.swift
//  CHAT
//
//  Created by 文戊 on 2018/9/12.
//  Copyright © 2018年 黑泡唱片. All rights reserved.
//

import Foundation
import FirebaseDatabase
class 评论数据库地址 {
    
    var 评论引用地址 = Database.database().reference().child("comments")
    
    func 评论总览(withId uid: String, completion: @escaping (评论Model) -> Void) {
        评论引用地址.child(uid).observeSingleEvent(of: .value, with: {
            快照 in
            if let 快照值 = 快照.value as? [String:Any]{
                let 新评论 = 评论Model.评论转换值(字典: 快照值)
                completion(新评论)
            }
        })
    }
}
