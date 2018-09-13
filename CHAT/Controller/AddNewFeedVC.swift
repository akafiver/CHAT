//
//  AddNewFeedVC.swift
//  CHAT
//
//  Created by 文戊 on 2018/9/9.
//  Copyright © 2018年 黑泡唱片. All rights reserved.
//

import UIKit
import SVProgressHUD

class AddNewFeedVC: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var 帖子图片: UIImageView!
    @IBOutlet weak var 帖子文字内容输入框: UITextView!
    @IBOutlet var 新建帖子页面: UIView!
    @IBOutlet weak var ShareButton: UIBarButtonItem!
    @IBOutlet weak var removedButton: UIBarButtonItem!
    
    var 已选择照片: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO:- 添加图像检测点击代码
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AddNewFeedVC.选择新照片))
        帖子图片.addGestureRecognizer(tapGesture)
        帖子图片.isUserInteractionEnabled=true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        激活按钮()
    }
    
    func 激活按钮(){
        if 已选择照片 != nil {
            self.ShareButton.isEnabled = true
            self.removedButton.isEnabled = true
        }else{
            self.ShareButton.isEnabled = false
            self.removedButton.isEnabled = false
        }
        
    }
    
    //TODO:- 键盘收起代码
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func 新建帖子页面点击(){
        帖子文字内容输入框.endEditing(true)
    }

    @objc func 选择新照片(){
        print("taptap")
         let imagePickerController=UIImagePickerController()
        imagePickerController.delegate=self
        present(imagePickerController, animated: true, completion: nil)
    }

    @IBAction func removeFeedButton(_ sender: UIBarButtonItem) {
        清除输入内容弹窗(tittle: "注意", message: "确定清除内容吗？")
    }
    
    //清除按钮Alert
    func 清除输入内容弹窗 (tittle: String, message: String){
        let 弹窗=UIAlertController(title: tittle, message: message, preferredStyle: .alert)
        弹窗.addAction(UIAlertAction(title: "取消", style: .default, handler: { (action) in }))
        弹窗.addAction(UIAlertAction(title: "清除", style: .cancel, handler: { (action) in self.清除Feed内容();self.激活按钮()}))
        self.present(弹窗, animated: true, completion: nil)
    }
    

    @IBAction func ShareButton(_ sender: UIBarButtonItem) {
        view.endEditing(true)
        SVProgressHUD.show()
        if let 帖子图片 = self.已选择照片, let 图片数据 = UIImageJPEGRepresentation(帖子图片, 0.1) {
            上传发送公式.上传图像数据至储存(帖子数据: 图片数据, 帖子文字内容: 帖子文字内容输入框.text!) {
                self.清除Feed内容()
                self.tabBarController?.selectedIndex=0
            }
        }
    }

    func 清除Feed内容() {
        self.帖子文字内容输入框.text=""
        self.帖子图片.image=UIImage(named: "图片固定背景")
        self.已选择照片=nil
    }

}

//MARK:- 点击启动相册代码
extension AddNewFeedVC:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("照片以选择")
        if let image=info["UIImagePickerControllerOriginalImage"] as? UIImage{
            已选择照片=image
            帖子图片.image=image
        }
//如需选择后相册消失，添加这段代码
        dismiss(animated: true, completion: nil)
    }
    
}
