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
import Snippets

protocol InputBarDelegate: NSObjectProtocol {
    func inputBar(_ inputBar: InputBarViewController, didSendText aText: String);
}

@IBDesignable class InputBarViewController: UIViewController {
    var inputViewDefaultHeight: CGFloat = 0.0
    
    weak var delegate: InputBarDelegate?
    
    /// 添加媒体按钮
    lazy var addButton: UIButton = {
        let addButton = UIButton(type: .custom);
        addButton.setImage(UIImage(named:"release_add"), for: .normal)
        addButton.addTarget(self, action: #selector(addAction), for: .touchUpInside)
        return addButton;
    }()
    
    /// 发送按钮
    lazy var sendButton: UIButton = {
        let sendButton = UIButton(type: .custom);
        sendButton.setTitle("发送", for: .normal)
        sendButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        sendButton.setTitleColor(.red, for: .normal)
        sendButton.setTitleColor(.lightGray, for: .disabled)
        sendButton.addTarget(self, action: #selector(sendAction), for: .touchUpInside)
        sendButton.isEnabled = false
        return sendButton;
    }()
    
    lazy var textContainer: UIView = {
        let textContainer = UIView()
        textContainer.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        textContainer.layer.cornerRadius = 5
        textContainer.layer.masksToBounds = true
        return textContainer
    }()
    
    /// 输入框
    lazy var textView: IQTextView = {
        let textView = IQTextView()
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.textContainerInset = .zero
        textView.placeholder = "输入内容···"
        textView.backgroundColor = .clear
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubviews()
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
            let margin: CGFloat = 4.0
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
        
        view.addSubview(textContainer)
        textContainer.snp.makeConstraints { (make) in
            let margin = 5.0
            make.top.equalTo(view.snp.top).offset(margin)
            make.leading.equalTo(addButton.snp.trailing).offset(margin)
            make.bottom.equalTo(view.snp.bottom).offset(-margin)
            make.trailing.equalTo(sendButton.snp.leading)
        }
        
        textView.delegate = self
        inputViewDefaultHeight = (textView.font?.lineHeight)!
        textContainer.addSubview(textView)
        textView.snp.makeConstraints { (make) in
            let margin = 10.0
            make.top.equalTo(textContainer.snp.top).offset(margin)
            make.leading.equalTo(textContainer.snp.leading).offset(margin * 0.5)
            make.bottom.equalTo(textContainer.snp.bottom).offset(-margin)
            make.trailing.equalTo(textContainer.snp.trailing).offset(-margin * 0.5)
            make.height.equalTo(40)
        }
        
        //调整输入框
        reloadInputView()
    }
    
    //MARK: - buttonAction
    func sendAction() {
        delegate?.inputBar(self, didSendText: textView.text)
        textView.text = ""
        reloadInputView()
    }
    
    func addAction() {
        print("添加")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension InputBarViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        reloadInputView()
    }
    
    /// 调整输入框
    func reloadInputView() {
        sendButton.isEnabled = textView.text.characters.count > 0
        if textView.text.characters.count > 0 {
            let height = textView.sizeThatFits(CGSize(width: textView.frame.width, height: .greatestFiniteMagnitude)).height
            //2是估算的行间距
            let maxHeight = 3 * inputViewDefaultHeight + 2
            
            if height >= maxHeight {
                textView.isScrollEnabled = true
                textView.snp.updateConstraints({ (make) in
                    make.height.equalTo(maxHeight)
                })
            } else {
                textView.isScrollEnabled = false
                textView.snp.updateConstraints({ (make) in
                    make.height.equalTo(height)
                })
            }
        } else {
            textView.isScrollEnabled = false
            textView.snp.updateConstraints({ (make) in
                make.height.equalTo(inputViewDefaultHeight)
            })
        }
    }
}

@IBDesignable class InputBarWithSpeechViewController: InputBarViewController {
    /// 切换输入模式按钮
    lazy var switchInputModeButton: UIButton = {
        let switchInputModeButton = UIButton(type: .custom);
        switchInputModeButton.setImage(UIImage(named:"release_input_speech"), for: .normal)
        switchInputModeButton.setImage(UIImage(named:"release_input_txt"), for: .selected)
        switchInputModeButton.addTarget(self, action: #selector(switchInputMode), for: .touchUpInside)
        return switchInputModeButton;
    }()
    
    /// 语音按钮
    lazy var speechButton: UIButton = {
        let speechButton = UIButton(type: .custom);
        speechButton.isHidden = true
        speechButton.setTitle("按住 说话", for: .normal)
        speechButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        speechButton.setTitleColor(UIColor.lightGray, for: .normal)
        speechButton.backgroundColor = UIColor.white
        speechButton.layer.cornerRadius = 5
        speechButton.layer.masksToBounds = true
        speechButton.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        speechButton.layer.borderWidth = 0.8
        return speechButton;
    }()
    
    func switchInputMode(_ button: UIButton) {
        button.isSelected = !button.isSelected
        
        reloadInputView(isSpeech: button.isSelected)
    }
    
    func reloadInputView(isSpeech: Bool) {
        speechButton.isHidden = !isSpeech
        if isSpeech {
            textView.resignFirstResponder()
            textView.snp.updateConstraints({ (make) in
                make.height.equalTo(inputViewDefaultHeight)
            })
        } else {
            textView.becomeFirstResponder()
            reloadInputView()
        }
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
        addButton.isHidden = true
        
        view.addSubview(switchInputModeButton)
        switchInputModeButton.snp.makeConstraints { (make) in
            make.top.leading.bottom.trailing.equalTo(addButton)
        }
        
        view.addSubview(speechButton)
        speechButton.snp.makeConstraints { (make) in
            make.top.leading.bottom.trailing.equalTo(textContainer)
        }
    }
}
