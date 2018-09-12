//
//  Post.swift
//  CHAT
//
//  Created by 文戊 on 2018/9/10.
//  Copyright © 2018年 黑泡唱片. All rights reserved.
//

import Foundation

class 帖子 {
    var text:String?
    var photoUrl:String?
    var uid:String?
    var id: String?
//    init(feedText:String,imageUrl:String){
//        text=feedText
//        photoUrl=imageUrl
////        uid=userID
//    }
    
}

extension 帖子 {
    static func 帖子照片转换值(字典: [String: Any],帖子辨识码:String) -> 帖子 {
        let post = 帖子()
        post.id = 帖子辨识码
        post.text = 字典["text"] as? String
        post.photoUrl = 字典["photoUrl"] as? String
        post.uid = 字典["uid"] as? String
        return post
    }
    
    static func transformPostVideo() {
        
    }
}
