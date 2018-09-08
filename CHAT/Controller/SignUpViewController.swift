//
//  SignUpViewController.swift
//  CHAT
//
//  Created by 文戊 on 2018/9/6.
//  Copyright © 2018年 黑泡唱片. All rights reserved.
//

import UIKit
import Firebase
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
        邮箱输入框.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.2).cgColor;
        邮箱输入框.layer.borderWidth = 1;
        邮箱输入框.layer.cornerRadius = 邮箱输入框.frame.size.height/2
        
        密码输入框.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.2).cgColor;
        密码输入框.layer.borderWidth = 1;
        密码输入框.layer.cornerRadius = 密码输入框.frame.size.height/2
        
        用户名称输入框.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.2).cgColor;
        用户名称输入框.layer.borderWidth = 1;
        用户名称输入框.layer.cornerRadius = 用户名称输入框.frame.size.height/2
        
        //TODO:-注册按钮样式设置
        注册按钮.layer.cornerRadius=注册按钮.frame.size.height/2
        注册按钮.layer.masksToBounds=true
        注册按钮.设置渐变(颜色1: 色值.蓝0E65D7, 颜色2: 色值.淡蓝5D9C5C)
        
        //TODO:- 页面点击检测代码
        let tapGesture=UITapGestureRecognizer(target: self, action: #selector(注册页面点击))
        注册页面.addGestureRecognizer(tapGesture)
       
    }
    
    @objc func 注册页面点击(){
        用户名称输入框.endEditing(true)
        邮箱输入框.endEditing(true)
        密码输入框.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- IBAction
    @IBAction func 点击注册按钮(_ sender: AnyObject) {
        
        //TODO:- 注册资料输入检测
        if let 用户名称输入 = 用户名称输入框.text, 用户名称输入 != "",
        let 邮箱输入 = 邮箱输入框.text, 邮箱输入 != "",
            let 密码输入 = 密码输入框.text, 密码输入 != ""{
            
            SVProgressHUD.show()

            //TODO: 向Firebase数据库设置新用户，并跳转主页
            Auth.auth().createUser(withEmail: 邮箱输入框.text!, password: 密码输入框.text!){ (user, error) in
                if error != nil{
                    print(error!)
                    SVProgressHUD.dismiss()
                    AlertController.showAlert(self, tittle: "错误", message: (error?.localizedDescription)!)
                }else{
                    print("注册成功")
                    SVProgressHUD.dismiss()
                    self.performSegue(withIdentifier: "前往首页", sender: self)
                    }
            }
        }else {
            AlertController.showAlert(self, tittle: "错误", message: "请输入完整资料")
            return
        }
        
        let userID = Auth.auth().currentUser!.uid
        print(userID)
        
        
//        let 用户名变更 = Auth.auth().currentUser?.createProfileChangeRequest()
//        UserProfileChangeRequest.willChangeValue(forKey: 用户名称输入框.text!)
  
    }
    
    //TODO:- 点击回车收回键盘:
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
}
