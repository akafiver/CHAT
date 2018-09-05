//
//  颜色管理.swift
//  CHAT
//
//  Created by 文戊 on 2018/9/5.
//  Copyright © 2018年 黑泡唱片. All rights reserved.
//

import UIKit
import Foundation

extension UIView {
    func 设置渐变(颜色1:UIColor,颜色2:UIColor){
        
        let 渐变层=CAGradientLayer()
        渐变层.frame=bounds
        渐变层.colors=[颜色1.cgColor,颜色2.cgColor]
        渐变层.locations=[0.0,1.0]
        渐变层.startPoint=CGPoint(x: 1.0, y: 1.0)
        渐变层.endPoint=CGPoint(x: 0.0, y: 0.0)
        
        layer.insertSublayer(渐变层, at: 0)
    }

}

struct 色值 {
    static let 黑 = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1)
    static let 铁黑4A4A4A = UIColor(red: 74.0/255.0, green: 74.0/255.0, blue: 74.0/255.0, alpha: 1)
    static let 白 = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1)
    static let 白FAFAFA = UIColor(red: 250.0/255.0, green: 250.0/255.0, blue: 250.0/255.0, alpha: 1)
    static let 淡蓝5D9C5C = UIColor(red: 93.0/255.0, green: 56.0/255.0, blue: 27.0/255.0, alpha: 1)
    static let 蓝0E65D7 = UIColor(red: 14.0/255.0, green: 101.0/255.0, blue: 215.0/255.0, alpha: 1)
}
