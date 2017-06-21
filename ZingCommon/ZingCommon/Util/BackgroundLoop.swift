//
//  BackgroundLoop.swift
//  ZingCommon
//
//  Created by 刘永峰 on 2017/6/19.
//  Copyright © 2017年 Witgo. All rights reserved.
//

import Foundation

public class BackgroundLoop {
    private static let INSTANCE = BackgroundLoop()
    
    private init() {
    }
    
    public class var `default`: BackgroundLoop {
        return INSTANCE
    }
    
    private var timer: Timer!
    private var queue: DispatchQueue!
    
}

class BackgroundLoopTask {
    
}
