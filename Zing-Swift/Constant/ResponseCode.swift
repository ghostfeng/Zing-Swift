//
//  ResponseCode.swift
//  Zing-Swift
//
//  Created by 刘永峰 on 2017/4/19.
//  Copyright © 2017年 Witgo. All rights reserved.
//

import Foundation

enum ResponseCode: Int32 {
    case success = 0
    case authenticationFailed = 401
    case authenticationException = 403
}
