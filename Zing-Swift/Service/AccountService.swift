//
//  AccountService.swift
//  Zing-Swift
//
//  Created by 刘永峰 on 2017/4/26.
//  Copyright © 2017年 Witgo. All rights reserved.
//

import UIKit

import ZingPBModel
import Snippets
import ZingCommon

import CloudPushSDK
import SwiftyJSON
import AVOSCloudIM

/// 用户服务
class AccountService: NSObject, AVIMClientDelegate {
    private static let INSTANCE = AccountService()
    private let upm = UserProfileManager.default
    private var _user: ZTMUserDescription!
    
    private override init() {
        super.init()
        
        ///注入获取用户关注频道列表的接口
        ZingFollowedChannel.default.getFollowedChannelsByApi = { closure in
            APIService.default.get(.channelsUser, queue: userInitiatedQueue, closure: { (path, response, error) in
                if let response = response {
                    if response.code == ZingResponseCode.success.rawValue {
                        closure(response.toppingChannelsArray.copy() as! [ZTMChannel], response.followedChannelsArray.copy() as! [ZTMChannel])
                    } else {
                        print("api error:", path, response.error)
                    }
                } else {
                    print("get error:", path, error!)
                }
            })
        }
    }
    
    class var `default`: AccountService {
        return INSTANCE
    }
    
    
    var isFirstLoginAtThisTime = true
    var user: ZTMUserDescription! {
        return _user
    }
    dynamic var imClient: AVIMClient!
    
    //MARK: - 登入、登出
    func loginWithTel(_ tel: String, password: String, telCode: String, closure: @escaping PBClosure) {
        APIService.default.post(.accountLoginByTel, parameters: ["tel": tel, "password": password, "telCode": telCode], queue: userInitiatedQueue) { (path, response, error) in
            if let response = response {
                if response.code == ZingResponseCode.success.rawValue {
                    self.doLocalLogin(user: response.user)
                }
            } else {
                print("post error", path, error!)
            }
            mainQueue.async {
                closure(path, response, error)
            }
        }
    }
    
    /// 登出
    func logout() {
        doLocalLogout()
        APIService.default.post(.accountLogout, queue: userInitiatedQueue)
    }
    
    /// 记录本地登录
    func doLocalLogin(user: ZTMUserDescription) {
        self._user = user
        APIService.default.token = user.tokenServer
        userInitiatedQueue.async {
            if self.isFirstLoginAtThisTime {
                self.isFirstLoginAtThisTime = false
                var status: String!
                switch APIService.default.networkStatus {
                case .unknown: status = "UNKNOWN"
                case .notReachable: status = "NOT REACHABLE"
                case .reachable(let type):
                    switch type {
                    case .ethernetOrWiFi: status = "WiFi"
                    case .wwan: status = "4G"
                    }
                }
                APIService.default.post(.appStarted, parameters:[ "os": UIDevice.osVersion(), "appVersion": Bundle.appVersion(), "model": UIDevice.unameMachine(), "network": status])
            }
            
            APIService.default.get3rd("https://api.map.baidu.com/location/ip", parameters: ["ak": BaiduWebAK], queue: userInitiatedQueue) { (path, data, error) in
                let updateUser = ZTMUserDescription()
                updateUser.id_p = user.id_p
                updateUser.timeZone = TimeZone.current.localizedName(for: .standard, locale: nil)!
                if let error = error {
                    print("baidu ip location error:", error)
                }
                if let data = data {
                    let json = JSON(data)
                    if json["status"].int != 0 {
                        print("baidu ip location error: ", json["message"].string ?? "unknow")
                    } else {
                        updateUser.cityCode = json["content"]["address_detail"]["city"].string!
                    }
                }
                /// 上传用户信息
                APIService.default.post(.accountUpdateRefresh, message: updateUser)
            }
            
            // 更新本地纪录
            self.upm.recordLogin(user: user)
            // 聊天连接
            self.imConnect()
            // 关注频道列表
            ZingFollowedChannel.default.launching()
            // 注册推送账户
            CloudPushSDK.bindAccount(user.id_p) { res in
                if (res!.success) {
                    print("Push SDK bindAccount success, accountId: ", self._user.id_p)
                } else {
                    print("Push SDK bindAccount failed, error: ", res!.error!)
                }
            }
        }
    }
    
    /// 记录本地登出
    func doLocalLogout() {
        _user = nil
        APIService.default.token = nil
        userInitiatedQueue.async {
            //更新本地记录为登出状态
            self.upm.recordLogout()
            //断开IM连接
            self.imConnectionClose()
            //阿里云推送账户解绑
            CloudPushSDK.unbindAccount({ (result) in
                if result!.success {
                    print("AliPush SDK unbindAccount success");
                } else {
                    print("AliPush SDK unbindAccount failed, error : \(result!.error!)")
                }
            })
        }
    }
    
    //MARK: - IM
    func imConnect() {
        imConnectionClose()
        if let user = _user {
            imClient = AVIMClient(clientId: user.id_p)
            imClient.delegate = self
            imClient.open(callback: { (success, error) in
                if !success {
                    print(error ?? "AVIMClient open failure with no error")
                } else {
                    //TODO:
                    print("AVIMClient open success")
                }
            })
        }
    }
    
    func imConnectionClose() {
        if imClient != nil {
            imClient.close(callback: { (success, error) in
                if !success {
                    print(error ?? "AVIMClient close failure with no error")
                }
            })
            imClient.delegate = nil
            imClient = nil
        }
    }
    
    // MARK:- AVIMClientDelegate
    
    /*!
     接收到新的普通消息。
     @param conversation － 所属对话
     @param message - 具体的消息
     */
    func conversation(_ conversation: AVIMConversation, didReceiveCommonMessage message: AVIMMessage) {
        
    }
    
    /*!
     收到未读通知。在该终端上线的时候，服务器会将对话的未读数发送过来。未读数可通过 -[AVIMConversation markAsReadInBackground] 清零，服务端不会自动清零。
     @param conversation 所属会话。
     @param unread 未读消息数量。
     */
    func conversation(_ conversation: AVIMConversation, didReceiveUnread unread: Int) {
        
    }
    
    deinit {
        imConnectionClose()
    }
}
