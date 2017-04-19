//
//  LocalProfileManager.swift
//  ZingPBModel
//
//  Created by 刘永峰 on 2017/4/19.
//  Copyright © 2017年 Witgo. All rights reserved.
//

import Foundation

/// 本地配置管理类
@objc public class LocalProfileManager: NSObject {
    private static let INSTANCE = LocalProfileManager()
    
    private override init() {
        super.init()
    }
    
    public class var defaultManager: LocalProfileManager {
        return INSTANCE
    }
    
    private let apc = ApplicationProfileContext.defaultContext
    
    // MARK:- 当前程序版本
    
    /// 是否是在本机第一次打开这个版本的程序
    var isFirstOpenAtTheVersion: Bool?
    
    /// 在完成appConfigManagemer.update之后调用
    public func record(localVersion: Int32) {
        if apc.localProfile.version == localVersion {
            isFirstOpenAtTheVersion = false
        } else {
            isFirstOpenAtTheVersion = true
            apc.localProfile.version = localVersion
            do {
                try apc.saveLocalProfile()
            } catch {
                print(error)
            }
        }
    }
}
