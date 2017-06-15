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
}

protocol Keyboard {
//    func keyboardFrameChange
}

class KeyboardService {
    private static let INSTANCE = KeyboardService()
    public class var `default`: KeyboardService {
        return INSTANCE
    }
    private init() {
        
    }
    
    lazy var info: KeyboardInfo = {
        let info = KeyboardInfo()
        return info
    }()
    
    var enable: Bool! {
        didSet {
            manager.enable = enable
        }
    }
    
    let manager = IQKeyboardManager.sharedManager()
    
    func launch() {
//        NotificationCenter.default.addObserver(self, selector: #selector(), name: <#T##NSNotification.Name?#>, object: <#T##Any?#>)
    }
    
}
