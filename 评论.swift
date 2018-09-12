//
//  Comment.swift
//  InstagramClone
//
//  Created by The Zero2Launch Team on 1/8/17.
//  Copyright © 2017 The Zero2Launch Team. All rights reserved.
//

import Foundation
class 评论Model {
    var 评论内容: String?
    var uid: String?
}

//红字内为上传至数据库的分类名称
extension 评论Model {
    static func 评论转换值(字典: [String: Any]) -> 评论Model {
        let 评论 = 评论Model()
        评论.评论内容 = 字典["commentText"] as? String
        评论.uid = 字典["uid"] as? String
        return 评论
    }
}
