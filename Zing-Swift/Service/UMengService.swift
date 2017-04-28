//
//  UMengService.swift
//  Zing-Swift
//
//  Created by 刘永峰 on 2017/4/27.
//  Copyright © 2017年 Witgo. All rights reserved.
//

import Foundation

/// 友盟服务
class UMengService{
    private static let INSTANCE = UMengService()
    let umm = UMSocialManager.default()!
    
    private init() {
    }
    
    class var `default`: UMengService {
        return INSTANCE
    }
    
    /// 启动加载
    func launching() {
        #if DEBUG
            umm.openLog(true)
        #endif
        umm.umSocialAppkey = UMKey
        
        // 进行https检查
        UMSocialGlobal.shareInstance().isUsingHttpsWhenShareContent = true
        
        let redirectURL = "https://www.zingapp.cn"
        
        // wechat
        umm.setPlaform(.wechatSession, appKey: WXAppId, appSecret: WXAppSecret, redirectURL: redirectURL)
        // QQ
        umm.setPlaform(.QQ, appKey: QQAppId, appSecret: QQAppSecret, redirectURL: redirectURL)
        // sina
        umm.setPlaform(.sina, appKey: SinaAppId, appSecret: SinaAppSecret, redirectURL: redirectURL)
    }
    
    func getAuthWithUserInfoFromWechat(vc: UIViewController, closure: @escaping (UMSocialUserInfoResponse?, Error?) -> Void) {
        umm.getUserInfo(with: .wechatSession, currentViewController: vc, completion: { any, error in
            if let any = any {
                let any = any as! UMSocialUserInfoResponse
                closure(any, nil)
                return
            }
            closure(nil, error)
        })
    }
    
    func handleOpen(url: URL!) -> Bool {
        return umm.handleOpen(url)
    }
}
