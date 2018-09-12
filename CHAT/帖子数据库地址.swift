//
//  帖子数据库地址.swift
//  CHAT
//
//  Created by 文戊 on 2018/9/12.
//  Copyright © 2018年 黑泡唱片. All rights reserved.
//

import Foundation
import Firebase
class 帖子数据库地址 {
    var 帖子引用地址 = Database.database().reference().child("posts")
    
    func 帖子总览(completion: @escaping (帖子Model) -> Void) {
        帖子引用地址.observe(.childAdded) { (快照:DataSnapshot) in
            if let 快照值 = 快照.value as? [String:Any]{
                let 新帖子=帖子Model.帖子照片转换值(字典: 快照值,帖子辨识码:快照.key)
                completion(新帖子)
            }
        }
    }
}

