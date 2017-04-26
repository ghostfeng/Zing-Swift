//
//  UserProfileManager.swift
//  ZingPBModel
//
//  Created by 刘永峰 on 2017/4/19.
//  Copyright © 2017年 Witgo. All rights reserved.
//

import Foundation

/// 用户配置管理类
@objc public class UserProfileManager: NSObject {
    private static let INSTANCE = UserProfileManager()
    
    private override init() {
        super.init()
    }
    
    public class var `default`: UserProfileManager {
        return INSTANCE
    }
    
    private let apc = ApplicationProfileContext.default
    private let lpm = LocalProfileManager.default
    
    /// 从本地留存的数据看是否已经登陆
    public var isLogin: Bool {
        return !apc.localProfile.userId.isEmpty && !(apc.userProfile?.tokenServer.isEmpty)!
    }
    
    /// 获得本地留存的数据中当前的用户ID
    public var currentUserId: String {
        return apc.localProfile.userId
    }
    
    /// 获得本地留存的数据中当前的用户Token Server
    public var currentTokenServer: String {
        return isLogin ? (apc.userProfile?.tokenServer)! : ""
    }
    
    /// 是否已经更新过appconfig
    public dynamic var isUpdated: Bool = false
    
    /// 记录登陆状态，在登陆之后调用
    public func recordLogin(user: ZTMUserDescription) {
        do {
            apc.localProfile.userId = user.id_p
            apc.localProfile.users.setValue(user, forKey: user.id_p)
            try apc.loadUserProfile()
            apc.userProfile?.tokenServer = user.tokenServer
            apc.userProfile?.user = user
            initHate()
            try apc.saveUserProfile()
            try apc.saveLocalProfile()
            if !isUpdated {
                isUpdated = true
            }
        } catch {
            print(error)
        }
    }
    
    /// 记录登出的状态，在登出之后调用
    public func recordLogout() {
        do {
            apc.localProfile.userId = nil
            apc.userProfile = nil
            clearHate()
            try apc.saveLocalProfile()
            if !isUpdated {
                isUpdated = true
            }
        } catch {
            print(error)
        }
    }
    
    //MARK: - 黑名单
    
    /// 拉入的黑名单用户ID集合
    private var hateTo: Set<String>!
    
    /// 被拉入黑名单的用户ID集合
    private var hateBy: Set<String>!
    
    /// 初始化黑名单
    private func initHate() {
        if let userProfile = apc.userProfile {
            hateTo = Set(userProfile.blacklist.hateUserIdsArray.copy() as! [String])
            hateBy = Set(userProfile.blacklist.beHatedUserIdsArray.copy() as! [String])
        }
    }
    
    /// 清除黑名单
    private func clearHate() {
        hateTo?.removeAll()
        hateBy?.removeAll()
    }
    
    /// 更新黑名单
    public func update(blackList: ZTMBlacklist) {
        apc.userProfile?.blacklist = blackList
        initHate()
        try! apc.saveUserProfile()
    }
    
    /// 移除黑名单，在获得黑名单对象是nil的时候调用
    public func removeAllBlacklist() {
        apc.userProfile?.blacklist.clear()
    }
    
    /// 是否被禁言
    public func isMute() -> Bool {
        if apc.userProfile?.blacklist.isMute == 0 {
            return false
        }
        return apc.userProfile?.blacklist.muteEndAt == 0 || (apc.userProfile?.blacklist.muteEndAt)! > UInt32(Date().timeIntervalSince1970)
    }
    
    /// 是否将某人加入了黑名单
    public func isHateTo(_ userId: String) -> Bool {
        return hateTo.contains(userId)
    }
    
    /// 是否自己被某人加入了黑名单
    public func isHateBy(_ userId: String) -> Bool {
        return hateBy.contains(userId)
    }
    
    /// 在操作了黑名单之后立即增加黑名单
    public func addHateTo(_ userId: String) {
        hateTo.insert(userId)
    }
    
    /// 在操作了黑名单之后立即移除黑名单
    public func removeHateTo(_ userId: String) {
        hateTo.remove(userId)
    }
    
}
