//
//  APIService.swift
//  Zing-Swift
//
//  Created by 刘永峰 on 2017/4/9.
//  Copyright © 2017年 Witgo. All rights reserved.
//

import Foundation
import Alamofire
import ZingPBModel

public typealias PBClosure = (ZTMZingResponse?, Error?) -> Void
public typealias JSONClosure = (Any?, Error?) -> Void

/// 网络请求服务类
class APIService {
    private static let INSTANCE = APIService()
    let getManager: Alamofire.SessionManager
    let postManager: Alamofire.SessionManager
    let networkReachabilityManager: Alamofire.NetworkReachabilityManager
    var networkStatus: Alamofire.NetworkReachabilityManager.NetworkReachabilityStatus = .unknown
    
    /// 获取网络请求服务类
    class var `default`: APIService {
        return INSTANCE
    }
    
    private init() {
        var config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        config.httpShouldUsePipelining = true
        config.timeoutIntervalForResource = 12
        postManager = Alamofire.SessionManager(configuration: config)
        
        config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        config.httpShouldUsePipelining = true
        config.timeoutIntervalForResource = 6
        getManager = Alamofire.SessionManager(configuration: config)
        networkReachabilityManager = Alamofire.NetworkReachabilityManager()!
        networkReachabilityManager.listener = {status in
            self.networkStatus = status
            switch status {
            case .unknown:
                print("net unknown!")
            case .notReachable:
                print("net notReachable!")
            case .reachable(let type):
                print("net reachableIn(\(type))")
            }
        }
        networkReachabilityManager.startListening()
    }
}
