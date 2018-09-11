//
//  CommentsTVCell.swift
//  CHAT
//
//  Created by 文戊 on 2018/9/11.
//  Copyright © 2018年 黑泡唱片. All rights reserved.
//

import UIKit

class CommentsTVCell: UITableViewCell {

    @IBOutlet weak var userNameLab: UILabel!
    @IBOutlet weak var userAvatarImage: UIImageView!
    @IBOutlet weak var commentLab: UILabel!
    
    
    var comment: Comment? {
        didSet {
            updateCommentsCellView()
        }
    }
    
    var user: User? {
        didSet {
            setupUserInfo()
        }
    }
    
    func updateCommentsCellView() {
        commentLab.text = comment?.commentText
    }
    
    func setupUserInfo() {
        userNameLab.text = user?.userName
        if let userAvatarImageUrlString = user?.userAvatarImageUrl {
            let photoUrl = URL(string: userAvatarImageUrlString)
            self.userAvatarImage.sd_setImage(with: photoUrl, placeholderImage:UIImage(named: "default-user-avatar"))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userNameLab.text = ""
        commentLab.text = ""
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userAvatarImage.image=UIImage(named: "default-user-avatar")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
