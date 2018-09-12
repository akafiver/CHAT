//
//  Post.swift
//  CHAT
//
//  Created by 文戊 on 2018/9/10.
//  Copyright © 2018年 黑泡唱片. All rights reserved.
//

import Foundation

class 帖子Model {
    var 帖子文字内容:String?
    var 帖子图片URL:String?
    var uid:String?
    var 帖子id: String?
//    init(feedText:String,imageUrl:String){
//        text=feedText
//        photoUrl=imageUrl
////        uid=userID
//    }
    
}
//红字内为上传至数据库的分类名称
extension 帖子Model {
    static func 帖子照片转换值(字典: [String: Any],帖子辨识码:String) -> 帖子Model {
        let 帖子 = 帖子Model()
        帖子.帖子id = 帖子辨识码
        帖子.帖子文字内容 = 字典["text"] as? String
        帖子.帖子图片URL = 字典["photoUrl"] as? String
        帖子.uid = 字典["uid"] as? String
        return 帖子
    }
    
    static func 帖子视频转换值() {
        
    }
}
