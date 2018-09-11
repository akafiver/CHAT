//
//  HomeFeedableViewCell.swift
//  CHAT
//
//  Created by 文戊 on 2018/9/10.
//  Copyright © 2018年 黑泡唱片. All rights reserved.
//

import UIKit
import Firebase

class HomeFeedableViewCell: UITableViewCell {

    @IBOutlet weak var feedImgV: UIImageView!
    @IBOutlet weak var userAvatarV: UIImageView!
    @IBOutlet weak var userNameLab: UILabel!
    @IBOutlet weak var feedText: UILabel!
    @IBOutlet weak var likeNom: UILabel!
    @IBOutlet weak var commentsNom: UILabel!
    
    var post:Post? {
        didSet {
            updateCellView()
        }
    }
    var user:User? {
        didSet {
            setupUserInfo()
        }
    }
    
    func updateCellView(){
        feedText.text=post?.text
        let photoUrlString = post?.photoUrl
        let photoUrl = URL(string: photoUrlString!)
        self.feedImgV.sd_setImage(with: photoUrl, completed: { [weak self] (image, error, cacheType, imageURL) in
            self?.feedImgV.image = image })
        setupUserInfo()
    }

    func setupUserInfo(){
        userNameLab.text=user?.userName
        if let userAvatarImageUrlString = user?.userAvatarImageUrl {
            let photoUrl = URL(string: userAvatarImageUrlString)
            self.userAvatarV.sd_setImage(with: photoUrl, placeholderImage:UIImage(named: "default-user-avatar"))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userNameLab.text = ""
        feedText.text = ""
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userAvatarV.image=UIImage(named: "default-user-avatar")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
