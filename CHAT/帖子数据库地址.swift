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
    
    func 单独帖子总览(withId 帖子id: String, completion: @escaping (帖子Model) -> Void) {
        帖子引用地址.child(帖子id).observeSingleEvent(of: DataEventType.value, with: {
            快照 in
            if let 字典 = 快照.value as? [String: Any] {
                let 帖子 = 帖子Model.帖子照片转换值(字典: 字典, 帖子辨识码: 快照.key)
                completion(帖子)
            }
        })
    }
    
    func 增量Likes(帖子Id: String, onSucess: @escaping (帖子Model) -> Void, onError: @escaping (_ errorMessage: String?) -> Void) {
        let 帖子引用 = 数据库地址.帖子地址.帖子引用地址.child(帖子Id)
        帖子引用.runTransactionBlock( { (当前数据: MutableData) -> TransactionResult in
            if var 帖子 = 当前数据.value as? [String : AnyObject], let uid = Auth.auth().currentUser?.uid {
                var 所有赞: Dictionary<String, Bool>
                所有赞 = 帖子["likes"] as? [String : Bool] ?? [:]
                var 赞计数 = 帖子["likeCount"] as? Int ?? 0
                if let _ = 所有赞[uid]
                { 赞计数 -= 1; 所有赞.removeValue(forKey: uid)} else { 赞计数 += 1; 所有赞[uid] = true }
                帖子["likeCount"] = 赞计数 as AnyObject?
                帖子["likes"] = 所有赞 as AnyObject?
                当前数据.value = 帖子
                return TransactionResult.success(withValue: 当前数据)
            }
            return TransactionResult.success(withValue: 当前数据)
        }) { (error, committed, 快照) in
            if let error = error {
                onError(error.localizedDescription)
            }
            if let 字典 = 快照?.value as? [String: Any] {
                let 帖子 = 帖子Model.帖子照片转换值(字典: 字典, 帖子辨识码: 快照!.key)
                onSucess(帖子)
            }
        }
    }
}

