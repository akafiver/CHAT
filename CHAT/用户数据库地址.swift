//
//  用户数据库地址.swift
//  CHAT
//
//  Created by 文戊 on 2018/9/12.
//  Copyright © 2018年 黑泡唱片. All rights reserved.
//

import Foundation
import Firebase

class 用户数据库地址 {
    var 用户引用地址 = Database.database().reference().child("users").child("profile")
    
    func 用户总览(withId uid: String, completion: @escaping (用户Model) -> Void) {
        用户引用地址.child(uid).observeSingleEvent(of: DataEventType.value, with: {
            快照 in
            if let 快照值 = 快照.value as? [String:Any]{
                let 用户 = 用户Model.用户转换值(字典: 快照值,key: 快照.key)
                completion(用户)
            }
        })
    }
    
    func 当前用户总览(completion: @escaping (用户Model) -> Void) {
        guard let 当前用户=Auth.auth().currentUser else{
            return
            }
            用户引用地址.child(当前用户.uid).observeSingleEvent(of: DataEventType.value, with: {
                快照 in
                if let 快照值 = 快照.value as? [String:Any]{
                    let 单个用户 = 用户Model.用户转换值(字典: 快照值, key: 快照.key)
                    completion(单个用户)
                }
            })
    
    }
    
    func 多个用户总览(completion: @escaping (用户Model) -> Void){
        用户引用地址.observe(.childAdded) { (快照) in
            if let 快照值 = 快照.value as? [String:Any]{
                let 用户 = 用户Model.用户转换值(字典: 快照值, key: 快照.key)
                completion(用户)
            }
        }
        
    }
    
    var 当前用户: User? {
        if let 当前用户 = Auth.auth().currentUser {
            return 当前用户
        }
        return nil
    }
    
    var 当前用户引用地址 : DatabaseReference? {
        guard let 当前用户=Auth.auth().currentUser else{
            return nil
        }
        return 用户引用地址.child(当前用户.uid)
    }
}
