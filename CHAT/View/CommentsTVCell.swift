//
//  CommentsTVCell.swift
//  CHAT
//
//  Created by 文戊 on 2018/9/11.
//  Copyright © 2018年 黑泡唱片. All rights reserved.
//

import UIKit

class CommentsTVCell: UITableViewCell {

    @IBOutlet weak var 用户名称: UILabel!
    @IBOutlet weak var 用户头像: UIImageView!
    @IBOutlet weak var 评论内容: UILabel!
    
    
    var 评论: 评论Model? {
        didSet {
            updateCommentsCellView()
        }
    }
    
    var 用户: 用户Model? {
        didSet {
            setupUserInfo()
        }
    }
    
    func updateCommentsCellView() {
        评论内容.text = 评论?.评论内容
    }
    
    func setupUserInfo() {
        用户名称.text = 用户?.用户名称
        if let 用户头像UrlString = 用户?.用户头像Url {
            let 图片Url = URL(string: 用户头像UrlString)
            self.用户头像.sd_setImage(with: 图片Url, placeholderImage:UIImage(named: "default-user-avatar"))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        用户名称.text = ""
        评论内容.text = ""
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        用户头像.image=UIImage(named: "default-user-avatar")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
