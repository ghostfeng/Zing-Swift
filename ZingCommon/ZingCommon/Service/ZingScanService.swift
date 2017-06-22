//
//  ZingScanService.swift
//  ZingCommon
//
//  Created by 刘永峰 on 2017/6/22.
//  Copyright © 2017年 Witgo. All rights reserved.
//

import Foundation

/// 扫描服务
public class ZingScanService: NSObject {
    private static let INSTANCE = ZingScanService()
    
    private override init() {
        super.init()
    }
    
    public class var `default`: ZingScanService {
        return INSTANCE
    }
    
}
