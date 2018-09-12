//
//  CommentsVCViewController.swift
//  CHAT
//
//  Created by 文戊 on 2018/9/11.
//  Copyright © 2018年 黑泡唱片. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class CommentsVC: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var loadingAnimat: UIActivityIndicatorView!
    @IBOutlet weak var 评论Table: UITableView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var 评论输入框: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    var 帖子ID:String!
    var 评论Array=[评论Model]()
    var 用户Array=[用户Model]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        评论输入框.delegate = self
        sendButton.isEnabled=false
        TextField监听()
        评论Table.estimatedRowHeight=57
        评论Table.rowHeight=UITableViewAutomaticDimension
        评论Table.dataSource=self
        loadComments()
//
        //TODO:- 输入框跟随键盘高度代码1.1
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    //------------------------------------------------------------------------
    //TODO:- 输入框跟随键盘高度代码1.2
    @objc func keyboardWillShow(_ notification: NSNotification) {
        print(notification)
        let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        UIView.animate(withDuration: 0.3) {
            self.heightConstraint.constant = keyboardFrame!.height
            self.view.layoutIfNeeded()}
    }
    @objc func keyboardWillHide(_ notification: NSNotification) {
        UIView.animate(withDuration: 0.3) {
            self.heightConstraint.constant = 0
            self.view.layoutIfNeeded()}
    }
    //------------------------------------------------------------------------
    
    //TODO:- 键盘收起代码
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //TODO:- TextField监听
    func TextField监听() {
        评论输入框.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControlEvents.editingChanged)
    }
    @objc func textFieldDidChange() {
        if let 评论文字 = 评论输入框.text, !评论文字.isEmpty {
            sendButton.setImage(UIImage(named: "导航 激活"), for: UIControlState.normal)
            sendButton.isEnabled=true
            return
        }
        sendButton.setImage(UIImage(named: "定位图标"), for: UIControlState.normal)
        sendButton.isEnabled=false
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //TODO:- TabBar在加载页面时隐藏
        self.tabBarController?.tabBar.isHidden=true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //TODO:- TabBar在离开页面时显示
        self.tabBarController?.tabBar.isHidden=false
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //TODO:- 点击发送按钮
    @IBAction func sendButton(_ sender: Any) {
        let commentsRef = Database.database().reference().child("comments")
        let newCommentsId = commentsRef.childByAutoId().key
        let newCommentReference = commentsRef.child(newCommentsId)
        guard Auth.auth().currentUser != nil else{return}
        let userID=Auth.auth().currentUser?.uid
        newCommentReference.updateChildValues(["uid":userID!,"commentText":评论输入框.text!], withCompletionBlock: {(error, ref) in
            if error != nil {SVProgressHUD.showError(withStatus: error!.localizedDescription);return}
            let postCommentRef = Database.database().reference().child("post-comments").child(self.帖子ID).child(newCommentsId)
            postCommentRef.setValue(true, withCompletionBlock: { (error, ref) in
                if error != nil {SVProgressHUD.showError(withStatus: error!.localizedDescription);return}
                print("评论成功")
            })
            //TODO:- 初始输入框清空
            self.清空输入框初始发送按钮()
            self.view.endEditing(true)
        })
    }
    func 清空输入框初始发送按钮(){
        self.评论输入框.text = ""
        self.sendButton.isEnabled=false
        self.sendButton.setImage(UIImage(named: "定位图标"), for: UIControlState.normal)


    }
    
    func loadComments(){
        loadingAnimat.startAnimating()
        Database.database().reference().child("post-comments").child(self.帖子ID).observe(.childAdded) { (snapshot:DataSnapshot) in
            Database.database().reference().child("comments").child(snapshot.key).observeSingleEvent(of: .value, with: {snapshotComment in
            if let snapshotValue = snapshotComment.value as? [String:Any]{
                let 新评论=评论Model.评论转换值(字典: snapshotValue)
                self.user读取(uid: 新评论.uid!, completed: {
                    self.评论Array.append(新评论)
                    self.loadingAnimat.stopAnimating()
                    self.评论Table.reloadData()
                    })
                }
            })
        }
    }

    
    func user读取(uid:String, completed:  @escaping () -> Void ) {
        Database.database().reference().child("users").child("profile").child(uid).observeSingleEvent(of: DataEventType.value, with: {
            snapshot in
            if let snapshotValue = snapshot.value as? [String:Any]{
                let user = 用户Model.用户转换值(字典: snapshotValue)
                self.用户Array.append(user)
                completed()
            }
        })
    }
    
    
    func 新建帖子页面点击(){
        评论输入框.endEditing(true)
    }
    //TODO:- 点击回车收回键盘:
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}


extension CommentsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 评论Array.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = 评论Table.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentsTVCell
        let 评论集合 = 评论Array[indexPath.row]
        let 用户集合 = 用户Array[indexPath.row]
        cell.评论 = 评论集合
        cell.用户 = 用户集合
        return cell
    }
}
