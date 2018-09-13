//
//  LoginViewController.swift
//  CHAT
//
//  Created by 文戊 on 2018/9/6.
//  Copyright © 2018年 黑泡唱片. All rights reserved.
//

import UIKit
import SVProgressHUD

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var 邮箱输入框: UITextField!
    @IBOutlet weak var 密码输入框: UITextField!
    @IBOutlet weak var 登录按钮: UIButton!
    @IBOutlet var 登录页面: UIView!
    
    var 激活输入框:UITextField!
    var keyBoardNeedLayout: Bool = true
 
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //TODO:- 输入框样式设置
        样式管理.邮箱密码输入框样式(layer: 邮箱输入框)
        样式管理.邮箱密码输入框样式(layer: 密码输入框)
        
        //TODO:- 登录按钮样式设置
        样式管理.注册登录按钮样式(layer: 登录按钮)
        
        //TODO:- 页面点击检测代码
        let tapGesture=UITapGestureRecognizer(target: self, action: #selector(登录页面点击))
        登录页面.addGestureRecognizer(tapGesture)

    }
    
    @objc func 登录页面点击(){
        邮箱输入框.endEditing(true)
        密码输入框.endEditing(true)
    }

//MARK:- MemoryWarning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
//MARK:- IBAction
    @IBAction func 点击登录按钮(_ sender: Any) {
        
        SVProgressHUD.show()
        //TODO:- 登录并跳转至主页
        登录公式.登录(邮箱: 邮箱输入框.text!, 密码: "123456", onSuccess: {
            print("登录成功")
            SVProgressHUD.dismiss()
            self.performSegue(withIdentifier: "前往首页", sender: self)
        }) { (error) in
            print(error!)
            SVProgressHUD.dismiss()
            AlertController.显示弹窗(self, tittle: "错误", message: error!)
        }
    }
    

    //TODO:- 开始输入:
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.1){
        }
        
    }
    //TODO:- 点击回车收回键盘:
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    

}
