//
//  GCDQueue.swift
//  Zing-Swift
//
//  Created by 刘永峰 on 2017/4/9.
//  Copyright © 2017年 Witgo. All rights reserved.
//

import Foundation

let mainQueue = DispatchQueue.main
let utilityQueue = DispatchQueue.global(qos: .utility)
let backgroundQueue = DispatchQueue.global(qos: .background)
let userInitiatedQueue = DispatchQueue.global(qos: .userInitiated)




