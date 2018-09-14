//
//  FollowApi.swift
//  InstagramClone
//
//  Created by The Zero2Launch Team on 1/30/17.
//  Copyright © 2017 The Zero2Launch Team. All rights reserved.
//

import Foundation
import FirebaseDatabase
class 关注数据库地址 {
    var 关注者引用地址 = Database.database().reference().child("followers")
    var 关注中引用地址 = Database.database().reference().child("following")
    
    func 关注动作(withUser id: String) {
        关注者引用地址.child(id).child(数据库地址.用户地址.当前用户!.uid).setValue(true)
        关注者引用地址.child(数据库地址.用户地址.当前用户!.uid).child(id).setValue(true)
    }
    
    func 取消关注动作(withUser id: String) {
        关注者引用地址.child(id).child(数据库地址.用户地址.当前用户!.uid).setValue(NSNull())
        关注者引用地址.child(数据库地址.用户地址.当前用户!.uid).child(id).setValue(NSNull())
    }
    
    func 正在关注(用户Id: String, completed: @escaping (Bool) -> Void) {
        关注者引用地址.child(用户Id).child(数据库地址.用户地址.当前用户!.uid).observeSingleEvent(of: .value, with: {
            快照 in
            if let _ = 快照.value as? NSNull {
                completed(false)
            } else {
                completed(true)
            }
        })
    }
}
