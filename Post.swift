//
//  Post.swift
//  CHAT
//
//  Created by 文戊 on 2018/9/10.
//  Copyright © 2018年 黑泡唱片. All rights reserved.
//

import Foundation

class Post {
    var text:String?
    var photoUrl:String?
    var uid:String?
    
//    init(feedText:String,imageUrl:String){
//        text=feedText
//        photoUrl=imageUrl
////        uid=userID
//    }
    
}

extension Post {
    static func PostPhoto转换值(dict: [String: Any]) -> Post {
        let post = Post()
        
        post.text = dict["text"] as? String
        post.photoUrl = dict["photoUrl"] as? String
        post.uid = dict["uid"] as? String
        return post
    }
    
    static func transformPostVideo() {
        
    }
}
