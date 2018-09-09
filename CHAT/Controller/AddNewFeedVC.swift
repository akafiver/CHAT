//
//  AddNewFeedVC.swift
//  CHAT
//
//  Created by 文戊 on 2018/9/9.
//  Copyright © 2018年 黑泡唱片. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import SVProgressHUD

class AddNewFeedVC: UIViewController {

    @IBOutlet weak var FeedImage: UIImageView!
    @IBOutlet weak var FeedTF: UITextView!
    
    var 已选择照片: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO:- 添加图像检测点击代码
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AddNewFeedVC.选择新照片))
        FeedImage.addGestureRecognizer(tapGesture)
        FeedImage.isUserInteractionEnabled=true
    }

    @objc func 选择新照片(){
        print("taptap")
         let imagePickerController=UIImagePickerController()
        imagePickerController.delegate=self
        present(imagePickerController, animated: true, completion: nil)
    }

    @IBAction func ShareButton(_ sender: UIBarButtonItem) {
        SVProgressHUD.show()
        if let FeedImag = self.已选择照片, let imageData = UIImageJPEGRepresentation(FeedImag, 0.1) {
            //指定文件唯一ID
            let photoIdString = NSUUID().uuidString
            //上传文件至Storage
            let storageRef = Storage.storage().reference(forURL: "gs://chat-32b03.appspot.com").child("posts").child(photoIdString)
            storageRef.putData(imageData, metadata: nil){ (metadata, error) in
                if error != nil {SVProgressHUD.showError(withStatus: error!.localizedDescription);return}else{print("上传成功", photoIdString);SVProgressHUD.dismiss()}
                //向storage获取文件URL
                storageRef.downloadURL(completion: { (url, error) in if error != nil {print("Failed to download url:", error!);return}
                    print(url!,"URL获取成功")
                    let imageUrl = url?.absoluteString
                    self.sendDataToDatabase(url:imageUrl!)
                    })
            }
        return }
    }
    
    //TODO:- 上传文件URL至database
    func sendDataToDatabase(url:String) {
        let ref = Database.database().reference()
        let postsRef = ref.child("posts")
        let newPostId = postsRef.childByAutoId().key
        let newPostReference = postsRef.child(newPostId)
        newPostReference.updateChildValues(["photoUrl": url], withCompletionBlock: {
            (error, ref) in
            if error != nil {
                SVProgressHUD.showError(withStatus: error!.localizedDescription)
                return
            }
            print("ulr成功上传")
            SVProgressHUD.showSuccess(withStatus: "Success")
        })
    }

}

//MARK:- 点击启动相册代码
extension AddNewFeedVC:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("照片以选择")
        if let image=info["UIImagePickerControllerOriginalImage"] as? UIImage{
            已选择照片=image
            FeedImage.image=image
        }
//如需选择后相册消失，添加这段代码   dismiss(animated: true, completion: nil)
    }
    
}
