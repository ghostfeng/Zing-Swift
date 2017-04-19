//
//  AppConfigManager.swift
//  ZingPBModel
//
//  Created by 刘永峰 on 2017/4/10.
//  Copyright © 2017年 Witgo. All rights reserved.
//

import UIKit

/// 应用配置管理类
@objc public class AppConfigManager: NSObject {
    private static let INSTANCE = AppConfigManager()
    private override init() {
        super.init()
    }
    
    /// 获得应用配置管理类
    public class var defaultManager: AppConfigManager {
        return INSTANCE
    }
    
    /// 应用级上下文
    private let apc = ApplicationProfileContext.defaultContext
    
    /// 是否已经更新过appconfig
    public dynamic var isUpdated = false
    
    // MARK:- url
    private var _apiUrl: String?
    private var _storageUrl: String?
    
    /// 更新APP配置，在系统启动之后，调用/services/app/config成功之后调用该方法
    public func update(_ appConfig: ZTMAppConfiguration) {
        apc.appConfig = appConfig
        if !isUpdated {
            isUpdated = true
        }
        do {
            try apc.saveAppConfig()
        } catch {
            print(error)
        }
        _apiUrl = nil
        _storageUrl = nil
    }
    
    /// 获取API的网络地址，形如https://api.zingapp.cn
    public var apiUrl: String{
        if let apiUrl = _apiUrl {
            return apiUrl
        } else {
            if apc.appConfig.urlDomain.apiScheme.isEmpty || apc.appConfig.urlDomain.api.isEmpty {
                if apc.isTestEnv {
                    return "https://testapi.zingapp.cn"
                } else {
                    return "https://api.zingapp.cn"
                }
            }
            _apiUrl = "\(apc.appConfig.urlDomain.apiScheme!)://\(apc.appConfig.urlDomain.api!)"
            return _apiUrl!
        }
    }
    /// 获取存储的网络地址，形如http://oss.zingapp.cn
    public var storageUrl: String {
        if let storageUrl = _storageUrl {
            return storageUrl
        } else {
            if apc.appConfig.urlDomain.storageScheme.isEmpty || apc.appConfig.urlDomain.storage.isEmpty {
                if apc.isTestEnv {
                    return "http://testoss.zingapp.cn"
                } else {
                    return "http://oss.zingapp.cn"
                }
            }
            _storageUrl = "\(apc.appConfig.urlDomain.storageScheme!)://\(apc.appConfig.urlDomain.storage!)"
            return _storageUrl!
        }
    }
    /// 获取网络存储bucket名称
    public var bucket: String {
        return apc.appConfig.urlDomain.bucket
    }
    /// 获取网络存储接口的对端地址
    public var bucketEndPoint: String {
        return apc.appConfig.urlDomain.bucketEndPoint
    }
}
