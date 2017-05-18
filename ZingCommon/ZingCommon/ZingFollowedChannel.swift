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
        getFollowedChannelsByApi? { toppingChannels, followedChannels in
            self._toppingChannels = toppingChannels
            self._followedChannels = followedChannels
            //通知刷新
            NotificationCenter.default.post(name: kZingFollowedChannelUpdated, object: self)
        }
    }
    
    //MARK: - 刷新行为
    
    /// 带有结束回调的刷新
    public func refresh(_ closure: @escaping () -> Void) {
        if hasNewSense {
            hasNewSense = false
        }
        lastRefreshAt = Date()
        getFollowedChannelsByApi? { toppingChannels, followedChannels in
            self._toppingChannels = toppingChannels
            self._followedChannels = followedChannels
            //通知刷新
            NotificationCenter.default.post(name: kZingFollowedChannelUpdated, object: self)
            //回调
            closure()
        }
    }
    
    //MARK: - 服务行为
    
    ///置顶
    public func top(channnelId: String, refresh: Bool = true) {
        if let followedChannels = _followedChannels {
            let index = followedChannels.index{ $0.id_p == channnelId}
            if let index = index {
                let toTop = _followedChannels!.remove(at: index)
                
                toTop.isTopping = .true
                
                if _toppingChannels != nil {
                    _toppingChannels!.insert(toTop, at: 0)
                } else {
                    _toppingChannels = [toTop]
                }
            }
        }
        
        if refresh {
            // 通知
            NotificationCenter.default.post(name: kZingFollowedChannelUpdated, object: self)
        }
    }
    
    ///取消置顶
    public func untop(channnelId: String, refresh: Bool = true) {
        if let toppingChannels = _toppingChannels {
            let index = toppingChannels.index{ $0.id_p == channnelId}
            if let index = index {
                let toUntop = _toppingChannels!.remove(at: index)
                
                toUntop.isTopping = .false
                
                if _followedChannels != nil {
                    _followedChannels!.insert(toUntop, at: 0)
                } else {
                    _followedChannels = [toUntop]
                }
            }
        }
        
        if refresh {
            // 通知
            NotificationCenter.default.post(name: kZingFollowedChannelUpdated, object: self)
        }
    }
    
    /// 添加关注
    public func follow(channel: ZTMChannel, refresh: Bool = true) {
        channel.isFollow = .true
        channel.unreadSenseCount = ""
        if _followedChannels != nil {
            _followedChannels!.insert(channel, at: 0)
        } else {
            _followedChannels = [channel]
        }
        
        if refresh {
            // 通知
            NotificationCenter.default.post(name: kZingFollowedChannelUpdated, object: self)
        }
    }
    
    /// 取消关注
    public func unfollow(channelId: String, refresh: Bool = true) {
        if let followedChannels = _followedChannels {
            let index = followedChannels.index { $0.id_p == channelId}
            if let index = index {
                _followedChannels!.remove(at: index)
            }
        }
        if let toppingChannels = _toppingChannels {
            let index = toppingChannels.index { $0.id_p == channelId}
            if let index = index {
                _toppingChannels!.remove(at: index)
            }
        }
        
        if refresh {
            // 通知
            NotificationCenter.default.post(name: kZingFollowedChannelUpdated, object: self)
        }
    }

    /// 创建
    public func create(channel: ZTMChannel, refresh: Bool = true) {
        if _followedChannels != nil {
            _followedChannels!.insert(channel, at: 0)
        } else {
            _followedChannels = [channel]
        }
        
        if refresh {
            // 通知
            NotificationCenter.default.post(name: kZingFollowedChannelUpdated, object: self)
        }
    }
}
