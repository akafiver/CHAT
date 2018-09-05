//
//  SignUpViewController.swift
//  CHAT
//
//  Created by 文戊 on 2018/9/6.
//  Copyright © 2018年 黑泡唱片. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var 邮箱输入框: UITextField!
    @IBOutlet weak var 密码输入框: UITextField!
    @IBOutlet weak var 注册按钮: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //TODO:-输入框样式设置
        邮箱输入框.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.2).cgColor;
        邮箱输入框.layer.borderWidth = 1;
        邮箱输入框.layer.cornerRadius = 邮箱输入框.frame.size.height/2
        
        密码输入框.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.2).cgColor;
        密码输入框.layer.borderWidth = 1;
        密码输入框.layer.cornerRadius = 密码输入框.frame.size.height/2
        
        //TODO:-登录按钮样式设置
        注册按钮.layer.cornerRadius=注册按钮.frame.size.height/2
        注册按钮.layer.masksToBounds=true
        注册按钮.设置渐变(颜色1: 色值.蓝0E65D7, 颜色2: 色值.淡蓝5D9C5C)
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
