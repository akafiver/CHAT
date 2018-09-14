//
//  上传发送公式.swift
//  CHAT
//
//  Created by 文戊 on 2018/9/14.
//  Copyright © 2018年 黑泡唱片. All rights reserved.
//

import Foundation
import Firebase
import SVProgressHUD
class 上传发送公式{
    
    static func 上传图像数据至储存(帖子数据:Data,帖子文字内容:String, onSuccess: @escaping () -> Void){
        //指定文件唯一ID
        let 图片唯一ID = NSUUID().uuidString
        //上传文件至Storage
        let 储存引用 = Storage.storage().reference(forURL: "gs://chat-32b03.appspot.com").child("posts").child(图片唯一ID)
        储存引用.putData(帖子数据, metadata: nil){ (metadata, error) in
            if error != nil {SVProgressHUD.showError(withStatus: error!.localizedDescription);return}else{print("上传成功", 图片唯一ID);SVProgressHUD.dismiss()}
            //向storage获取文件URL
            储存引用.downloadURL(completion: { (url, error) in if error != nil {print("url下载失败:", error!);return}
                print(url!,"URL获取成功")
                //上传文件URL至database
                let 图片Url = url?.absoluteString
                发送数据至数据库(url: 图片Url!, 帖子文字内容: 帖子文字内容, onSuccess: onSuccess)
            })
        }
    }

    static func 发送数据至数据库(url:String,帖子文字内容:String, onSuccess: @escaping () -> Void) {
        let 新帖子ID = 数据库地址.帖子地址.帖子引用地址.childByAutoId().key
        let 新帖子引用 = 数据库地址.帖子地址.帖子引用地址.child(新帖子ID)
        guard Auth.auth().currentUser != nil else{return}
        let 当前用户ID=Auth.auth().currentUser?.uid
        新帖子引用.updateChildValues(["uid":当前用户ID!,"photoUrl": url,"text":帖子文字内容], withCompletionBlock: {(error, ref) in
            if error != nil {SVProgressHUD.showError(withStatus: error!.localizedDescription)
                return
            }
            print("ulr成功上传")
            Database.database().reference().child("feed").child(数据库地址.用户地址.当前用户!.uid).child(新帖子ID).setValue(true)
            let 我的帖子引用=数据库地址.用户帖子地址.用户帖子引用地址.child(当前用户ID!).child(新帖子ID)
            我的帖子引用.setValue(true, withCompletionBlock: { (error, ref) in
                if error != nil {SVProgressHUD.showError(withStatus: error!.localizedDescription)
                    return
                }
                print("评论成功")
            })
            SVProgressHUD.showSuccess(withStatus: "Success")
            onSuccess()
        })
    }
    
    
    static func 上传头像图像至储存(头像数据:Data, onSuccess: @escaping () -> Void){
        //指定文件唯一ID
        let 用户头像图片String = 数据库地址.用户地址.当前用户?.uid
        //上传文件至Storage
        let 储存引用 = Storage.storage().reference(forURL: "gs://chat-32b03.appspot.com").child("userAvatarImage").child(用户头像图片String!)
        储存引用.putData(头像数据, metadata: nil){ (metadata, error) in
            if error != nil {SVProgressHUD.showError(withStatus: error!.localizedDescription);return}else{print("上传成功", 用户头像图片String!);SVProgressHUD.dismiss()}
            //向storage获取文件URL
            储存引用.downloadURL(completion: { (url, error) in if error != nil {print("Failed to download url:", error!);return}
                print(url!,"URL获取成功")
                //上传文件URL至database
                let 用户头像图片Url = url?.absoluteString
                头像上传至数据库(url: 用户头像图片Url!, onSuccess: onSuccess)
            })
        }
    }

    static func 头像上传至数据库(url:String, onSuccess: @escaping () -> Void) {
        let 头像引用 = Database.database().reference().child("users").child("profile").child((Auth.auth().currentUser?.uid)!)
        guard Auth.auth().currentUser != nil else{return}
        _=Auth.auth().currentUser?.uid
        头像引用.updateChildValues(["userAvatarImageUrl": url], withCompletionBlock: {(error, ref) in
            if error != nil {SVProgressHUD.showError(withStatus: error!.localizedDescription);return}
            print("ulr成功上传")
            SVProgressHUD.showSuccess(withStatus: "Success")
            onSuccess()
        })
    }
}
