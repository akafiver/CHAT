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

    @IBOutlet weak var 帖子图片: UIImageView!
    @IBOutlet weak var 用户头像: UIImageView!
    @IBOutlet weak var 用户名称: UILabel!
    @IBOutlet weak var 帖子文字内容: UILabel!
    @IBOutlet weak var 获赞数量: UILabel!
    @IBOutlet weak var 评论数量: UILabel!

    var homeVC:HomeVC?
    
    var 帖子:帖子Model? {
        didSet {
            updateCellView()
        }
    }
    var 用户:用户Model? {
        didSet {
            setupUserInfo()
        }
    }
    
    func updateCellView(){
        帖子文字内容.text=帖子?.帖子文字内容
        let 图片UrlString = 帖子?.帖子图片URL
        let 图片Url = URL(string: 图片UrlString!)
        self.帖子图片.sd_setImage(with: 图片Url, completed: { [weak self] (image, error, cacheType, imageURL) in
            self?.帖子图片.image = image })
        setupUserInfo()
    }

    func setupUserInfo(){
        用户名称.text=用户?.用户名称
        if let 用户头像UrlString = 用户?.用户头像Url {
            let 图片Url = URL(string: 用户头像UrlString)
            self.用户头像.sd_setImage(with: 图片Url, placeholderImage:UIImage(named: "default-user-avatar"))
        }
    }
    
    
    @IBAction func commentButtonInCell(_ sender: Any) {
        if let id = 帖子?.帖子id {homeVC?.performSegue(withIdentifier: "toCommentsPage", sender: id)}
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        用户名称.text = ""
        帖子文字内容.text = ""
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
