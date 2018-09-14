//
//  Feed数据库地址.swift
//  CHAT
//
//  Created by 文戊 on 2018/9/14.
//  Copyright © 2018年 黑泡唱片. All rights reserved.
//

import Foundation
import Firebase
class Feed数据库地址 {
    var Feed引用地址 = Database.database().reference().child("feed")
    
    func Feed总览(withId id: String, completion: @escaping (帖子Model) -> Void) {
        Feed引用地址.child(id).observe(.childAdded, with: {
            快照 in
            let key = 快照.key
            数据库地址.帖子地址.单独帖子总览(withId: key, completion: { (帖子) in
                completion(帖子)
            })
        })
    }
    
    func Feed移除总览(withId id: String, completion: @escaping (String) -> Void) {
        Feed引用地址.child(id).observe(.childRemoved, with: {
            快照 in
            let key = 快照.key
            completion(key)
        })
    }
}
