//
//  EditProfileVC.swift
//  CHAT
//
//  Created by 文戊 on 2018/9/11.
//  Copyright © 2018年 黑泡唱片. All rights reserved.
//

import Foundation
import UIKit
import Firebase
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
            //指定文件唯一ID
            let 用户头像图片String = Auth.auth().currentUser?.uid
            //上传文件至Storage
            let 储存引用 = Storage.storage().reference(forURL: "gs://chat-32b03.appspot.com").child("userAvatarImage").child(用户头像图片String!)
            储存引用.putData(图片数据, metadata: nil){ (metadata, error) in
                if error != nil {SVProgressHUD.showError(withStatus: error!.localizedDescription);return}else{print("上传成功", 用户头像图片String!);SVProgressHUD.dismiss()}
                //向storage获取文件URL
                储存引用.downloadURL(completion: { (url, error) in if error != nil {print("Failed to download url:", error!);return}
                    print(url!,"URL获取成功")
                    //上传文件URL至database
                    let 用户头像图片Url = url?.absoluteString
                    self.发送数据至数据库(url:用户头像图片Url!)
                })
            };return}
    }
    
    //TODO:- 上传文件URL至database
    func 发送数据至数据库(url:String) {
        let 头像引用 = Database.database().reference().child("users").child("profile").child((Auth.auth().currentUser?.uid)!)
        guard Auth.auth().currentUser != nil else{return}
        _=Auth.auth().currentUser?.uid
        头像引用.updateChildValues(["userAvatarImageUrl": url], withCompletionBlock: {(error, ref) in
            if error != nil {SVProgressHUD.showError(withStatus: error!.localizedDescription);return}
            print("ulr成功上传")
            SVProgressHUD.showSuccess(withStatus: "Success")
            self.tabBarController?.selectedIndex=3
        })
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
