//
//  UMengService.swift
//  Zing-Swift
//
//  Created by 刘永峰 on 2017/4/27.
//  Copyright © 2017年 Witgo. All rights reserved.
//

import Foundation

/// 友盟服务
class UMengService {
    private static let INSTANCE = UMengService()
    
    private init() {
    }
    
    class var `default`: UMengService {
        return INSTANCE
    }
}
