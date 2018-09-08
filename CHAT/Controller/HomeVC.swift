//
//  HomeVC.swift
//  CHAT
//
//  Created by 文戊 on 2018/9/8.
//  Copyright © 2018年 黑泡唱片. All rights reserved.
//

import UIKit
import Firebase

class HomeVC: UIViewController {

    @IBOutlet weak var 欢迎语: UILabel!
    let 用户 = Auth.auth().currentUser?.displayName
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        欢迎语.text="Hello \(用户))"

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}