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
    static func showAlert (_ inViewController: UIViewController, tittle: String, message: String){
        let alert=UIAlertController(title: tittle, message: message, preferredStyle: .alert)
        let action=UIAlertAction(title: "OK", style:.default, handler: nil)
        alert.addAction(action)
        inViewController.present(alert, animated: true, completion: nil)
    }
    
    

}
