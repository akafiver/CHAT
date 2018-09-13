//
//  EditProfileVC.swift
//  CHAT
//
//  Created by 文戊 on 2018/9/11.
//  Copyright © 2018年 黑泡唱片. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage
import SVProgressHUD
class EditProfileVc: UIViewController {
    
    var 已选择照片: UIImage?

    @IBOutlet weak var 用户头像图片: UIImageView!
    @IBOutlet weak var 用户名称: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO:- 添加图像检测点击代码
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(EditProfileVc.选择新照片))
        用户头像图片.addGestureRecognizer(tapGesture)
        用户头像图片.isUserInteractionEnabled=true
    }
    
    @objc func 选择新照片(){
        print("taptap")
        let imagePickerController=UIImagePickerController()
        imagePickerController.delegate=self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func 完成按钮(_ sender: Any) {
        view.endEditing(true)
        SVProgressHUD.show()
        if let 帖子图片 = self.已选择照片, let 图片数据 = UIImageJPEGRepresentation(帖子图片, 0.1) {
            上传发送公式.上传头像图像至储存(头像数据: 图片数据) {
                self.tabBarController?.selectedIndex=3
            }
        }
    }
    
}

//MARK:- 点击启动相册代码
extension EditProfileVc:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("照片以选择")
        if let image=info["UIImagePickerControllerOriginalImage"] as? UIImage{
            已选择照片=image
            用户头像图片.image=image
        }
        //如需选择后相册消失，添加这段代码
        dismiss(animated: true, completion: nil)
    }

}
