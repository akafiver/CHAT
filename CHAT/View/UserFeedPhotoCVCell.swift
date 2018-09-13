//
//  PhotoCollectionViewCell.swift
//  InstagramClone
//
//  Created by The Zero2Launch Team on 1/15/17.
//  Copyright © 2017 The Zero2Launch Team. All rights reserved.
//

import UIKit

class UserFeedPhotoCVCell: UICollectionViewCell {
    @IBOutlet weak var photo: UIImageView!
    var 帖子: 帖子Model? {
        didSet {
            更新界面()
        }
    }
    
    func 更新界面() {
        if let 帖子图片URLString = 帖子?.帖子图片URL {
            let 图片Url = URL(string: 帖子图片URLString)
            photo.sd_setImage(with: 图片Url)
        }
    }
}
