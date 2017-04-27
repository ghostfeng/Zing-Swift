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
import CloudPushSDK
import SwiftyJSON

/// 用户服务
class AccountService: NSObject {
    private static let INSTANCE = AccountService()
    private let upm = UserProfileManager.default
    private var user: ZTMUserDescription!
    
    private override init() {
        super.init()
    }
    
    class var `default`: AccountService {
        return INSTANCE
    }
    
    
    var isFirstLoginAtThisTime = true
    var curentUser: ZTMUserDescription! {
        return user
    }
    
    //MARK: - 登入、登出
    func loginWithTel(_ tel: String, password: String, telCode: String, closure: @escaping PBClosure) {
        APIService.default.post(.accountLoginByTel, parameters: ["tel": tel, "password": password, "telCode": telCode], queue: userInitiatedQueue) { (path, response, error) in
            mainQueue.async {
                closure(path, response, error)
            }
            if let response = response {
                if response.code == ZingResponseCode.success.rawValue {
                    self.doLocalLogin(user: response.user)
                }
            } else {
                print("post error", path, error!)
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
        self.user = user
        APIService.default.token = user.tokenServer
        userInitiatedQueue.async {
            if self.isFirstLoginAtThisTime {
                self.isFirstLoginAtThisTime = false
//                var status: String!
//                switch APIService.default.networkStatus {
//                case .unknown: status = "UNKNOWN"
//                case .notReachable: status = "NOT REACHABLE"
//                case .reachable(let type):
//                    switch type {
//                    case .ethernetOrWiFi: status = "WIFI"
//                    case .wwan: status = "4G"
//                    }
//                }
//                APIService.default.post(.appStarted, parameters:[ "os": UIDevice.current.name + " " + UIDevice.current.systemVersion, "appVersion": Bundle.main.infoDictionary!["CFBundleVersion"] as! String, "model": UIDevice.unameMachine(), "network": status])
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
            // 注册推送账户
            CloudPushSDK.bindAccount(user.id_p) { res in
                if (res!.success) {
                    print("Push SDK bindAccount success, accountId: ", self.user.id_p)
                } else {
                    print("Push SDK bindAccount failed, error: ", res!.error!)
                }
            }
        }
    }
    
    /// 记录本地登出
    func doLocalLogout() {
        user = nil
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
    }
    
    func imConnectionClose() {
    }
}
