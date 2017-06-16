//
//  KeyboardService.swift
//  Zing-Swift
//
//  Created by 刘永峰 on 2017/6/15.
//  Copyright © 2017年 Witgo. All rights reserved.
//

import Foundation
import IQKeyboardManagerSwift

public struct KeyboardInfo {
    var height: CGFloat = 0
    var duration: TimeInterval = 0
    var beginFrame: CGRect = .zero
    var endFrame: CGRect = .zero
}

protocol KeyboardServiceDelegate: NSObjectProtocol {
    func keyboardFrameChange(withInfo info: KeyboardInfo)
}

class KeyboardService {
    private static let INSTANCE = KeyboardService()
    public class var `default`: KeyboardService {
        return INSTANCE
    }
    private init() {
        launch()
    }
    
    lazy var info: KeyboardInfo = {
        let info = KeyboardInfo()
        return info
    }()
    
    weak var delegate: KeyboardServiceDelegate?
    
    var enable: Bool! {
        didSet {
            manager.enable = enable
        }
    }
    
    let manager = IQKeyboardManager.sharedManager()
    
    func launch() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardChangeFrame(notification:)), name: .UIKeyboardWillChangeFrame, object: nil)
        manager.enable = false
        manager.shouldResignOnTouchOutside = true
        manager.shouldToolbarUsesTextFieldTintColor = true
        manager.enableAutoToolbar = false
        manager.preventShowingBottomBlankSpace = true
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillChangeFrame, object: nil)
    }
    
    @objc func keyboardChangeFrame(notification: NSNotification) {
        let keyBoardBeginFrame = notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! CGRect
        let keyBoardEndFrame = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! CGRect
        let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        let height = (keyBoardEndFrame.origin.y == UIScreen.main.bounds.size.height) ? 0 : keyBoardEndFrame.size.height
        self.info.beginFrame = keyBoardBeginFrame
        self.info.endFrame = keyBoardEndFrame
        self.info.duration = duration
        self.info.height = height
        delegate?.keyboardFrameChange(withInfo: self.info)
    }
    
}
