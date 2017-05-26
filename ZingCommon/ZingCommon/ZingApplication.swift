//
//  ZingApplication.swift
//  ZingCommon
//
//  Created by 刘永峰 on 2017/5/17.
//  Copyright © 2017年 Witgo. All rights reserved.
//

import UIKit

/// 应用服务
public class ZingApplication: NSObject {
    
    public static let tab_channel = "channel"
    public static let tab_discovery = "discovery"
    public static let tab_message = "message"
    public static let tab_me = "me"
    
    static let INSTANCE = ZingApplication()
    
    override private init() {
        super.init()
    }
    
    /// 应用进入后台的时间
    public dynamic var enterBackgroundAt = Date()
    
    /// 应用进入前台的时间
    public dynamic var enterForegroundAt = Date()
    
    /// 当前Tab页面的切换时间
    public var tabChangeAt = Date()
    
    /// 当前Tab页面
    public dynamic var tab = tab_channel
    
    public class var `default`: ZingApplication {
        return INSTANCE
    }
    
    public func changeTab(_ tab: String) {
        if self.tab != tab {
            self.tab = tab
            tabChangeAt = Date()
        }
    }
}
