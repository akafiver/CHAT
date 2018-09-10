//
//  WelcomePageViewController.swift
//  CHAT
//
//  Created by 文戊 on 2018/9/6.
//  Copyright © 2018年 黑泡唱片. All rights reserved.
//

import UIKit

class WelcomePageViewController: UIViewController {

    @IBOutlet weak var 登录按钮: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        样式管理.注册登录按钮样式(layer: 登录按钮)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

}
