//
//  DiscoverUsersTVC.swift
//  CHAT
//
//  Created by 文戊 on 2018/9/14.
//  Copyright © 2018年 黑泡唱片. All rights reserved.
//

import UIKit

class DiscoverUsersTVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var 用户Array=[用户Model]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource=self
        读取用户()

    }
    
    func 读取用户() {
        数据库地址.用户地址.多个用户总览 { (用户) in
            self.正在关注(用户Id: 用户.用户ID!, completed: { (值) in
                用户.正在关注=值
                self.用户Array.append(用户)
                self.tableView.reloadData()
            })
        }
    }
    func 正在关注(用户Id: String, completed: @escaping (Bool) -> Void) {
        数据库地址.关注地址.正在关注(用户Id: 用户Id, completed: completed)
    }
    
}

extension DiscoverUsersTVC:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "discoverUsersTVCell", for: indexPath) as! DiscoverUsersTVCell
        let 用户集合=用户Array[indexPath.row]
        cell.用户=用户集合
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 用户Array.count
    }
}
