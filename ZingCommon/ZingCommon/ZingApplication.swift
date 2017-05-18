//
//  ZingApplication.swift
//  ZingCommon
//
//  Created by 刘永峰 on 2017/5/17.
//  Copyright © 2017年 Witgo. All rights reserved.
//

import UIKit

public class ZingApplication: NSObject {
    static let INSTANCE = ZingApplication()
    
    override private init() {
        super.init()
    }
    
    public class var `default`: ZingApplication {
        return INSTANCE
    }
}
