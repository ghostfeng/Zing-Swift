//
//  ApplicationProfileContext.swift
//  ZingPBModel
//
//  Created by 刘永峰 on 2017/4/9.
//  Copyright © 2017年 Witgo. All rights reserved.
//

import UIKit


/// 路径分隔符
private let FSP = "/"

/// 配置文件的根路径
private let PROFILE_ROOT_PATH = NSHomeDirectory() + FSP + "Library" + FSP + "Caches" + FSP + "profile" + FSP

/// APP配置文件的路径
private let APP_CONFIG_FILE_PATH = PROFILE_ROOT_PATH + ".appconfig"

/// 本地配置文件的路径
private let LOCAL_PROFILE_FILE_PATH =  PROFILE_ROOT_PATH + ".localprofile"

/// 用户配置文件名称
private let USER_PROFILE_FILE_NAME = ".profile"

/// 附件名称
private let ATTACHMENTS_NAME = "attachments" + FSP

/// 应用级上下文，单例, 用于存储应用中的各级数据
@objc public class ApplicationProfileContext: NSObject {
    private static let INSTANCE = ApplicationProfileContext()
    private let fileManager = FileManager.default
    
    /// 应用级上下文
    public class var defaultContext: ApplicationProfileContext {
        return INSTANCE
    }
    
    /// 是否是测试环境
    public var isTestEnv = false
    
    /// 应用配置
    public var appConfig = ZTMAppConfiguration()
    
    /// 本地配置
    public var localProfile = ZTMLocalProfile()
    
    /// 用户配置
    public var userProfile: ZTMUserLocalProfile?
    
    override private init() {
        super.init()
        
        if !fileManager.fileExists(atPath: PROFILE_ROOT_PATH) {
            do {
                try fileManager.createDirectory(atPath: PROFILE_ROOT_PATH, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error)
            }
        } else {
            do {
                try load()
            } catch {
                print(error)
            }
        }
    }
    
    public func load() throws {
        try loadAppConfig()
        try loadLocalProfile()
        try loadUserProfile()
    }
    
    public func loadAppConfig() throws {
        if fileManager.fileExists(atPath: APP_CONFIG_FILE_PATH) {
            let data = FileHandle(forReadingAtPath: APP_CONFIG_FILE_PATH)?.readDataToEndOfFile()
            if let data = data {
                do {
                    try appConfig = ZTMAppConfiguration(data: data)
                } catch {
                    try fileManager.removeItem(atPath: APP_CONFIG_FILE_PATH)
                }
            }
        }
    }
    
    public func loadLocalProfile() throws {
        if fileManager.fileExists(atPath: LOCAL_PROFILE_FILE_PATH) {
            let data = FileHandle(forReadingAtPath: LOCAL_PROFILE_FILE_PATH)?.readDataToEndOfFile()
            if let data = data {
                do {
                    try localProfile = ZTMLocalProfile(data: data)
                } catch {
                    try fileManager.removeItem(atPath: LOCAL_PROFILE_FILE_PATH)
                }
            }
        }
    }
    
    public func loadUserProfile() throws {
        if let userId = localProfile.userId {
            //相当于finally
            defer {
                if userProfile == nil {
                    userProfile = ZTMUserLocalProfile()
                }
            }
            
            // 根据已经存在本地配置中当前登陆的用户ID获得用户配置
            let userProfilePath = PROFILE_ROOT_PATH + userId + FSP + USER_PROFILE_FILE_NAME
            if fileManager.fileExists(atPath: userProfilePath) {
                let data = FileHandle(forReadingAtPath: userProfilePath)?.readDataToEndOfFile()
                if let data = data {
                    do {
                        try userProfile = ZTMUserLocalProfile(data: data)
                    } catch {
                        try fileManager.removeItem(atPath: userProfilePath)
                    }
                }
            }
        }
    }
    
    public func save() throws {
        try saveAppConfig()
        try saveLocalProfile()
        try saveUserProfile()
        
    }
    
    public func saveAppConfig() throws {
        if let data = appConfig.data() {
            try data.write(to: URL(fileURLWithPath:APP_CONFIG_FILE_PATH))
        }
    }
    
    public func saveLocalProfile() throws {
        if let data = localProfile.data() {
            try data.write(to: URL(fileURLWithPath: LOCAL_PROFILE_FILE_PATH))
        }
    }
    
    public func saveUserProfile() throws {
        if let userId = localProfile.userId, userId != "", let userProfile = userProfile, let data = userProfile.data() {
            let userPath = PROFILE_ROOT_PATH + userId + FSP
            if !fileManager.fileExists(atPath: userPath) {
                try fileManager.createDirectory(atPath: userPath, withIntermediateDirectories: true)
            }
            let userProfilePath = userPath + USER_PROFILE_FILE_NAME
            try data.write(to: URL(fileURLWithPath: userProfilePath))
        }
    }
}
