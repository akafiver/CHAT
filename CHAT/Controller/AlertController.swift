//
//  AlertController.swift
//  CHAT
//
//  Created by 文戊 on 2018/9/7.
//  Copyright © 2018年 黑泡唱片. All rights reserved.
//

import UIKit

class AlertController{
    
    let feedFunction=AddNewFeedVC()

    //MARK:-登录注册页错误弹窗
    static func 显示弹窗 (_ inViewController: UIViewController, tittle: String, message: String){
        let 弹窗=UIAlertController(title: tittle, message: message, preferredStyle: .alert)
        let 动作=UIAlertAction(title: "OK", style:.default, handler: nil)
        弹窗.addAction(动作)
        inViewController.present(弹窗, animated: true, completion: nil)
    }
    
    

}
