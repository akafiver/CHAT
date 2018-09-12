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

    @IBOutlet weak var userAvatarImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO:- 添加图像检测点击代码
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(EditProfileVc.选择新照片))
        userAvatarImage.addGestureRecognizer(tapGesture)
        userAvatarImage.isUserInteractionEnabled=true
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
        if let FeedImag = self.已选择照片, let imageData = UIImageJPEGRepresentation(FeedImag, 0.1) {
            //指定文件唯一ID
            let userAvatarImageString = Auth.auth().currentUser?.uid
            //上传文件至Storage
            let storageRef = Storage.storage().reference(forURL: "gs://chat-32b03.appspot.com").child("userAvatarImage").child(userAvatarImageString!)
            storageRef.putData(imageData, metadata: nil){ (metadata, error) in
                if error != nil {SVProgressHUD.showError(withStatus: error!.localizedDescription);return}else{print("上传成功", userAvatarImageString!);SVProgressHUD.dismiss()}
                //向storage获取文件URL
                storageRef.downloadURL(completion: { (url, error) in if error != nil {print("Failed to download url:", error!);return}
                    print(url!,"URL获取成功")
                    //上传文件URL至database
                    let userAvatarImageUrl = url?.absoluteString
                    self.sendDataToDatabase(url:userAvatarImageUrl!)
                })
            };return}
    }
    
    //TODO:- 上传文件URL至database
    func sendDataToDatabase(url:String) {
        let AvatarRef = Database.database().reference().child("users").child("profile").child((Auth.auth().currentUser?.uid)!)
        guard Auth.auth().currentUser != nil else{return}
        _=Auth.auth().currentUser?.uid
        AvatarRef.updateChildValues(["userAvatarImageUrl": url], withCompletionBlock: {(error, ref) in
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
            userAvatarImage.image=image
        }
        //如需选择后相册消失，添加这段代码
        dismiss(animated: true, completion: nil)
    }

}