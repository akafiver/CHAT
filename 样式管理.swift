//
//  样式管理.swift
//  CHAT
//
//  Created by 文戊 on 2018/9/5.
//  Copyright © 2018年 黑泡唱片. All rights reserved.
//

import UIKit
import Foundation

class 样式管理:UIView {
    static func 样式(layer:UIImageView){
        layer.layer.shadowColor=UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0).cgColor
        layer.layer.shadowOffset=CGSize(width: 0, height: 6.0)
        layer.layer.shadowRadius=30
        layer.layer.shadowOpacity=0.3
    }
    
    static func 注册登录按钮样式(layer:UIButton){
        layer.layer.cornerRadius=layer.frame.size.height/2
        layer.layer.masksToBounds=true
        layer.设置渐变(颜色1: 色值.蓝0E65D7, 颜色2: 色值.淡蓝5D9C5C)
        layer.layer.shadowColor=UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0).cgColor
        layer.layer.shadowOffset=CGSize(width: 0, height: 6.0)
        layer.layer.shadowRadius=30
        layer.layer.shadowOpacity=0.3
    }
    
    static func 邮箱密码输入框样式(layer:UITextField){
        layer.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.2).cgColor;
        layer.layer.borderWidth = 1;
        layer.layer.cornerRadius = layer.frame.size.height/2
    }
    
    static func 头像样式(layer:UIImageView){
        layer.layer.cornerRadius = 16
        layer.layer.shadowColor=UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0).cgColor
        layer.layer.shadowOffset=CGSize(width: 0, height: 6.0)
        layer.layer.shadowRadius=30
        layer.layer.shadowOpacity=0.3
    }
    
    static func 图片样式(layer:UIImageView){
        layer.layer.cornerRadius = 15
        layer.layer.shadowColor=UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0).cgColor
        layer.layer.shadowOffset=CGSize(width: 0, height: 6.0)
        layer.layer.shadowRadius=30
        layer.layer.shadowOpacity=0.3
    }
    
    static func 正在关注按钮样式(layer:UIButton){
        layer.layer.borderWidth = 1
        layer.layer.borderColor = UIColor(red: 226/255, green: 228/255, blue: 232.255, alpha: 1).cgColor
        layer.setTitleColor(UIColor.white, for: UIControlState.normal)
        layer.backgroundColor = UIColor(red: 69/255, green: 142/255, blue: 255/255, alpha: 1)
        layer.setTitle("关注", for: UIControlState.normal)
    }
    
    static func 取消关注按钮样式(layer:UIButton){
        layer.layer.borderWidth = 1
        layer.layer.borderColor = UIColor(red: 226/255, green: 228/255, blue: 232.255, alpha: 1).cgColor
        layer.setTitleColor(UIColor.black, for: UIControlState.normal)
        layer.backgroundColor = UIColor.clear
        layer.setTitle("关注中", for: UIControlState.normal)
    }
}
