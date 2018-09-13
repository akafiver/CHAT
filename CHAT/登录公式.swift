//
//  登录公式.swift
//  CHAT
//
//  Created by 文戊 on 2018/9/14.
//  Copyright © 2018年 黑泡唱片. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage
import SVProgressHUD

class 登录公式 {
    
    static func 登录(邮箱: String, 密码: String, onSuccess: @escaping () -> Void, onError:  @escaping (_ errorMessage: String?) -> Void) {
        Auth.auth().signIn(withEmail: 邮箱, password: 密码) { (user, error) in
            if error != nil{
                SVProgressHUD.dismiss()
                onError (error?.localizedDescription)
            }else{
                onSuccess()
            }
        }
    }
    
    static func 注册(用户名称:String,邮箱: String, 密码: String, onSuccess: @escaping () -> Void, onError:  @escaping (_ errorMessage: String?) -> Void) {
        Auth.auth().createUser(withEmail: 邮箱, password: 密码) { (user, error) in
            if error != nil{
                SVProgressHUD.dismiss()
                onError (error?.localizedDescription)
            }else{
                onSuccess()
                self.创建用户profile(用户名称: 用户名称, 邮箱: 邮箱, 密码: 密码, uid:(Auth.auth().currentUser?.uid)! , onSuccess: onSuccess)
            }
        }
    }
    
    static func 创建用户profile(用户名称:String,邮箱:String,密码:String,uid: String, onSuccess: @escaping () -> Void) {
     let 用户数据库 = Database.database().reference().child("users").child("profile")
        用户数据库.child((Auth.auth().currentUser?.uid)!).updateChildValues(["userName": 用户名称, "email": 邮箱,"uid": Auth.auth().currentUser?.uid as Any])
        onSuccess()
    
    }
    
    static func 登出(onSuccess: @escaping () -> Void, onError:  @escaping (_ errorMessage: String?) -> Void) {
        do {
            try Auth.auth().signOut()
            print("登出成功")
            onSuccess()
            
        } catch let logoutError {
            print("登出错误")
            onError(logoutError.localizedDescription)
        }
    }
    
}
