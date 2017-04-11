//
//  RequestPath.swift
//  Zing-Swift
//
//  Created by 刘永峰 on 2017/4/9.
//  Copyright © 2017年 Witgo. All rights reserved.
//

import Foundation

enum RequestPath: String {
    // 系统配置
    case appConfig = "/app/config"
    case appStarted = "/app/started"
    case appShutdown = "/app/shutdown"
    
    // OSS
    case ossToken = "/oss/token"
    
    // 频道搜索
    case channelsSearch = "/channels/category/{category}/search"
    
    // 账户登录
    case accountLoginByTokenServer = "/account/login/ts"
    case accountLoginByTel = "/account/login/tel"
    case accountLoginByWX = "/account/login/wx"
    case accountLogout = "/account/logout"
    
    // 账户管理
    case accountUpdate = "/account/update"
    case accountUpdateRefresh = "/account/update/refresh"
    
    // 聊天会话
    case contactsesCvs = "/contactses/cvs"
    case getContacts = "/contacts/{contactsId}/detail"
    case createContactsCvs = "/contacts/cvs/create"
    
    // 频道列表
    case channelsUser = "/channels/user"
}
