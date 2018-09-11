//
//  UserProfileViewController.swift
//  CHAT
//
//  Created by 文戊 on 2018/9/6.
//  Copyright © 2018年 黑泡唱片. All rights reserved.
//

import UIKit
import Firebase

class UserProfileViewController: UIViewController {


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
  
    }
    
    
//MARK:- 登出
    
    @IBAction func 点击登出按钮(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            print("登出成功")
//            self.performSegue(withIdentifier: "回到欢迎页", sender: self)
        }catch{
            print("登出错误")
        }
        let storyboard=UIStoryboard(name: "Main", bundle: nil)
        let 登录页面 = storyboard.instantiateViewController(withIdentifier: "登录页")
        self.present(登录页面, animated: true, completion: nil)
    }
    


}
