//
//  LoginViewController.swift
//  CHAT
//
//  Created by 文戊 on 2018/9/6.
//  Copyright © 2018年 黑泡唱片. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var 邮箱输入框: UITextField!
    @IBOutlet weak var 密码输入框: UITextView!
    @IBOutlet weak var 登录按钮: UIButton!
    @IBOutlet var 登录页面: UIView!
    
    var 激活输入框:UITextField!
    var keyBoardNeedLayout: Bool = true
 
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO:- 输入框样式设置
        邮箱输入框.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.2).cgColor;
        邮箱输入框.layer.borderWidth = 1;
        邮箱输入框.layer.cornerRadius = 邮箱输入框.frame.size.height/2
        
        密码输入框.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.2).cgColor;
        密码输入框.layer.borderWidth = 1;
        密码输入框.layer.cornerRadius = 密码输入框.frame.size.height/2
        
        //TODO:- 登录按钮样式设置
        登录按钮.layer.cornerRadius=登录按钮.frame.size.height/2
        登录按钮.layer.masksToBounds=true
        登录按钮.设置渐变(颜色1: 色值.蓝0E65D7, 颜色2: 色值.淡蓝5D9C5C)
        
        //TODO:- 页面点击检测代码
        let tapGesture=UITapGestureRecognizer(target: self, action: #selector(登录页面点击))
        登录页面.addGestureRecognizer(tapGesture)

        
    }

//MARK:- MemoryWarning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
//MARK:- IBAction
    @IBAction func 点击登录按钮(_ sender: Any) {
        
        SVProgressHUD.show()
        
        
//MARK:- FUNC
        //TODO:- 登录并跳转至主页
        Auth.auth().signIn(withEmail: 邮箱输入框.text!, password: 密码输入框.text!) { (user, error) in
            if error != nil{
                print(error!)
                SVProgressHUD.dismiss()
            }else{
                print("登录成功")
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "前往首页", sender: self)
            }
        }
    }
    
    @objc func 登录页面点击(){
        邮箱输入框.endEditing(true)
        密码输入框.endEditing(true)
    }
    
    //TODO:- 开始输入:
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.1){
        }
    }
    //TODO:- 点击回车:
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        邮箱输入框.resignFirstResponder()
        密码输入框.resignFirstResponder()
        return(true)
    }

}
