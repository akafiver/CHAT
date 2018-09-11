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
    
    
    func updateCellView(post:Post){
        userNameLab.text="leon 玛莎拉蒂"
        userAvatarV.image=UIImage(named: "avatar.jpg")
        feedText.text=post.text
        let photoUrlString = post.photoUrl
        let photoUrl = URL(string: photoUrlString)
        self.feedImgV.sd_setImage(with: photoUrl, completed: { [weak self] (image, error, cacheType, imageURL) in
            self?.feedImgV.image = image })
//        setupUserInfo()
    }
    
//    func setupUserInfo(){
//        if let uid = Auth.auth().currentUser?.uid != nil{
//            Database.database().reference().child("users").observeSingleEvent(of: DataEventType.value) { (snapShot) in
//                if let snapshotValue = snapshot.value as? [String:Any]{
//                    let text = snapshotValue["text"] as! String
//                    let url = snapshotValue["photoUrl"] as! String
//                    let uid = snapshotValue["userID"] as! String
//                    let post = Post(feedText: text, imageUrl: url, userID: uid)
//                }
//            }
//        }
//    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    @IBAction func likeButton(_ sender: Any) {
    }
    @IBAction func commentsButton(_ sender: Any) {
    }
    @IBAction func moreInfoButton(_ sender: Any) {
    }
    
}
