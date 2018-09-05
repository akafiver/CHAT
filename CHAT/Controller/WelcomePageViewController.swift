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
        
        登录按钮.layer.cornerRadius=登录按钮.frame.size.height/2
        登录按钮.layer.masksToBounds=true
//        view.设置渐变(颜色1: 色值.白, 颜色2: 色值.白FAFAFA)
        登录按钮.设置渐变(颜色1: 色值.蓝0E65D7, 颜色2: 色值.淡蓝5D9C5C)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

}
