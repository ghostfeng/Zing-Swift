//
//  AppConfigManager.swift
//  ZingPBModel
//
//  Created by 刘永峰 on 2017/4/10.
//  Copyright © 2017年 Witgo. All rights reserved.
//

import UIKit

/// 应用配置管理类
@objc class AppConfigManager: NSObject {
    private static let INSTANCE = AppConfigManager()
    private override init() {
        super.init()
    }
    
    /// 获得应用配置管理类
    class var defaultManager: AppConfigManager {
        return INSTANCE
    }
}
