//
//  UserProfileViewController.swift
//  CHAT
//
//  Created by 文戊 on 2018/9/6.
//  Copyright © 2018年 黑泡唱片. All rights reserved.
//

import UIKit
import SVProgressHUD

class UserProfileViewController: UIViewController {

    @IBOutlet weak var 用户页面CollectionView: UICollectionView!
    
    var 用户:用户Model!
    var 所有帖子: [帖子Model] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        用户页面CollectionView.dataSource=self
        用户页面CollectionView.delegate=self
        提取用户()
        提取用户帖子()
    }

    func 提取用户(){
        数据库地址.用户地址.当前用户总览 { (单个用户) in
            self.用户=单个用户
            self.title=单个用户.用户名称
            self.用户页面CollectionView.reloadData()
        }
    }
    
    func 提取用户帖子(){
        guard let 提取用户 = 用户数据库地址().当前用户 else {
            return
        }
        数据库地址.用户帖子地址.用户帖子引用地址.child(提取用户.uid).observe(.childAdded, with: {
            snapshot in
            数据库地址.帖子地址.单独帖子总览(withId: snapshot.key, completion: {
                帖子Model in
                print(帖子Model.帖子id!)
                self.所有帖子.append(帖子Model)
                self.用户页面CollectionView.reloadData()
            })
        })
    }
    
//MARK:- 登出
    
    @IBAction func 点击登出按钮(_ sender: Any) {
        登录公式.登出(onSuccess: {
            let storyboard=UIStoryboard(name: "Main", bundle: nil)
            let 登录页面 = storyboard.instantiateViewController(withIdentifier: "登录页")
            self.present(登录页面, animated: true, completion: nil)
        }) { (error) in
            SVProgressHUD.showError(withStatus: error)
        }
    }
    


}

extension UserProfileViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 所有帖子.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profilePhotoCell", for: indexPath) as! UserFeedPhotoCVCell
        let 帖子 = 所有帖子[indexPath.row]
        cell.帖子=帖子
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let 头部卡片=collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "ProfileSestion", for: indexPath) as! UserPorfileCardCRV
        if let 用户=self.用户{
            头部卡片.用户=用户
        }
        return 头部卡片
    }
    
}

extension UserProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return -10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 3 , height: collectionView.frame.size.width / 3  )
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if UIDevice.current.userInterfaceIdiom == .phone {
//            return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
//        } else {
//
//            // Number of Items per Row
//            let numberOfItemsInRow = 2
//
//            // Current Row Number
//            let rowNumber = indexPath.item/numberOfItemsInRow
//
//            // Compressed With
//            let compressedWidth = collectionView.bounds.width/3
//
//            // Expanded Width
//            let expandedWidth = (collectionView.bounds.width/3) * 2
//
//            // Is Even Row
//            let isEvenRow = rowNumber % 2 == 0
//
//            // Is First Item in Row
//            let isFirstItem = indexPath.item % numberOfItemsInRow != 0
//
//            // Calculate Width
//            var width: CGFloat = 0.0
//            if isEvenRow {
//                width = isFirstItem ? compressedWidth : expandedWidth
//            } else {
//                width = isFirstItem ? expandedWidth : compressedWidth
//            }
//
//            return CGSize(width: width, height: collectionView.bounds.height)
//        }
//    }
}
