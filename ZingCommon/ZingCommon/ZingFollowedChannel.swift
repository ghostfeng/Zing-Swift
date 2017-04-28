//
//  ZingFollowedChannel.swift
//  ZingCommon
//
//  Created by 刘永峰 on 2017/4/28.
//  Copyright © 2017年 Witgo. All rights reserved.
//

import Foundation

import ZingPBModel
import Snippets

/// 需要监听的通知名称
public let kZingFollowedChannelUpdated = NSNotification.Name(rawValue: "kZingFollowedChannelUpdated")


/// 关注的频道管理
@objc public class ZingFollowedChannel: NSObject {
    private static let INSTANCE = ZingFollowedChannel()
    
    private override init() {
        super.init()
    }
    
    /// 获得单例
    public class var `default`: ZingFollowedChannel {
        return INSTANCE
    }
    
    //MARK: - 数据源
    
    //置顶的频道
    private var _toppingChannels: [ZTMChannel]?
    public var toppingChannels: [ZTMChannel]? {
        return _toppingChannels
    }
    
    //关注的频道
    private var _followedChannels: [ZTMChannel]?
    public var followedChannels: [ZTMChannel]? {
        return _followedChannels
    }
    
    public dynamic var hasNewSense = false
    public var lastRefreshAt = Date()
    
    /// 获得用户关注的频道列表
    public var getFollowedChannelsByApi: ((@escaping (_ toppingChannels: [ZTMChannel], _ followedChannels: [ZTMChannel]) -> Void) -> Void)?
    
    public func launching() {
        if hasNewSense {
            hasNewSense = false
        }
        lastRefreshAt = Date()
        getFollowedChannelsByApi? {
            toppingChannels, followedChannels in {
                self._toppingChannels = toppingChannels
                self._followedChannels = followedChannels
                //通知刷新
                NotificationCenter.default.post(name: kZingFollowedChannelUpdated, object: self)
            }
        }
    }
    
    //MARK: - 刷新行为
    
    //MARK: - 服务行为
    
    public func top(channnelId: String, refresh: Bool = true) {
        if let followedChannels = self._followedChannels {
            let index = followedChannels.index{ $0.id_p == channnelId}
            if let index = index {
                let toTop = followedChannels.remove(at: index)
                
                toTop.isTopping = .YES
                
                if let toppingChannels = self._toppingChannels {
                    toppingChannels.insert(toTop, at: 0)
                } else {
                    self._toppingChannels = [toTop]
                }
            }
        }
    }
    
}
