//
//  InputBarViewController.swift
//  Zing-Swift
//
//  Created by 刘永峰 on 2017/6/15.
//  Copyright © 2017年 Witgo. All rights reserved.
//

import UIKit

import SnapKit
import IQKeyboardManagerSwift

class InputBarViewController: UIViewController {
    
    /// 添加媒体按钮
    var addButton: UIButton = {
        let addButton = UIButton(type: .custom);
        addButton.setImage(UIImage(named:"release_add"), for: .normal)
        addButton.addTarget(self, action: #selector(adddAction), for: .touchUpInside)
        return addButton;
    }()
    
    /// 发送按钮
    var sendButton: UIButton = {
        let sendButton = UIButton(type: .custom);
        sendButton.setTitle("发送", for: .normal)
        sendButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        sendButton.setTitleColor(.red, for: .normal)
        sendButton.setTitleColor(.lightGray, for: .disabled)
        sendButton.addTarget(self, action: #selector(sendAction), for: .touchUpInside)
        return sendButton;
    }()
    
    /// 输入框
    var textView: IQTextView = {
        let textView = IQTextView()
        textView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        textView.layer.cornerRadius = 5
        textView.layer.masksToBounds = true
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupSubviews() {
        view.backgroundColor = .white
        
        let line = UIView()
        line.backgroundColor = UIColor.lightGray.withAlphaComponent(0.8)
        view.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.leading.equalTo(view.snp.leading)
            make.top.equalTo(view.snp.top)
            make.trailing.equalTo(view.snp.trailing)
            make.height.equalTo(0.5)
        }
        
        view.addSubview(addButton)
        addButton.snp.makeConstraints { (make) in
            let margin = 6;
            make.leading.equalTo(view.snp.leading).offset(margin)
            make.bottom.equalTo(view.snp.bottom).offset(-margin)
            make.width.height.equalTo(40)
        }
        
        view.addSubview(sendButton)
        sendButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(view.snp.trailing)
            make.height.equalTo(40)
            make.width.equalTo(55)
            make.centerY.equalTo(addButton.snp.centerY)
        }
        
        view.addSubview(textView)
        textView.snp.makeConstraints { (make) in
            let margin = 5.0
            make.top.equalTo(view.snp.top).offset(margin)
            make.leading.equalTo(addButton.snp.trailing).offset(margin)
            make.bottom.equalTo(view.snp.bottom).offset(-margin)
            make.trailing.equalTo(sendButton.snp.leading)
            make.height.equalTo(40)
        }
    }
    
    func sendAction() {
        print("发送")
    }
    
    func adddAction() {
        print("添加")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
