//
//  SignUpViewController.swift
//  CHAT
//
//  Created by 文戊 on 2018/9/6.
//  Copyright © 2018年 黑泡唱片. All rights reserved.
//

import UIKit
import SVProgressHUD

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var 用户名称输入框: UITextField!
    @IBOutlet weak var 邮箱输入框: UITextField!
    @IBOutlet weak var 密码输入框: UITextField!
    @IBOutlet weak var 注册按钮: UIButton!
    @IBOutlet var 注册页面: UIView!
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        

        //TODO:-输入框样式设置
        样式管理.邮箱密码输入框样式(layer: 邮箱输入框)
        样式管理.邮箱密码输入框样式(layer: 密码输入框)
        样式管理.邮箱密码输入框样式(layer: 用户名称输入框)
        
        //TODO:-注册按钮样式设置
        样式管理.注册登录按钮样式(layer: 注册按钮)
        
        //TODO:- 页面点击检测代码
        let tapGesture=UITapGestureRecognizer(target: self, action: #selector(注册页面点击))
        注册页面.addGestureRecognizer(tapGesture)
       
    }
    
    @objc func 注册页面点击(){
        用户名称输入框.endEditing(true)
        邮箱输入框.endEditing(true)
        密码输入框.endEditing(true)
    }

    
    //MARK:- IBAction
    @IBAction func 点击注册按钮(_ sender: AnyObject) {
        //TODO:- 注册资料输入检测
        guard let 用户名称输入 = 用户名称输入框.text, 用户名称输入 != "",
        let 邮箱输入 = 邮箱输入框.text, 邮箱输入 != "",
            let 密码输入 = 密码输入框.text, 密码输入 != ""
            else{AlertController.显示弹窗(self, tittle: "错误", message: "请输入完整资料");return}
        SVProgressHUD.show()
        //TODO: 向Firebase数据库设置新用户，并跳转主页
            登录公式.注册(用户名称: 用户名称输入框.text!, 邮箱: 邮箱输入框.text!, 密码: 密码输入框.text!, onSuccess: {
                print("注册成功")
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "前往首页", sender: self)
            }) { (error) in
                print(error!)
                SVProgressHUD.dismiss()
                AlertController.显示弹窗(self, tittle: "错误", message: error!)
            }
        }
    
    //TODO:- 点击回车收回键盘:
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}








//
//    func 创建用户profile(){
//        let 用户数据库 = Database.database().reference().child("users")
//        let profileDictionary = ["email": Auth.auth().currentUser?.email, "userName": self.用户名称输入框.text!,"uid": Auth.auth().currentUser?.uid]
//        用户数据库.child("profile").child((Auth.auth().currentUser?.uid)!).updateChildValues(profileDictionary as Any as! [AnyHashable : Any]) { (error, ref) in
//            if error != nil {print(error!)}else {print("信息保存成功")
//            self.用户名称输入框.isEnabled = true
//            self.邮箱输入框.isEnabled = true
//            self.用户名称输入框.text = ""
//            }
//        }
//    }
