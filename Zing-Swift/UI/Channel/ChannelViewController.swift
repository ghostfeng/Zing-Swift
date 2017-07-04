//
//  ChannelViewController.swift
//  Zing-Swift
//
//  Created by 刘永峰 on 2017/5/10.
//  Copyright © 2017年 Witgo. All rights reserved.
//

import UIKit

import ZingCommon
import Snippets
import ZingPBModel

class ChannelViewController: BaseViewController {
    
    lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView(frame: self.view.bounds, style: .grouped)
        tableView.hideExtraHeader()
        tableView.hideExtraFooter()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    lazy var topRowAction: UITableViewRowAction = {
        let topRowAction: UITableViewRowAction = UITableViewRowAction(style: .normal, title: "置顶", handler: { [unowned self] (action, indexPath) in
            self.topChannel(atIndexPath: indexPath)
        })
        return topRowAction
    }()
    
    lazy var untopRowAction: UITableViewRowAction = {
        let untopRowAction: UITableViewRowAction = UITableViewRowAction(style: .normal, title: "取消置顶", handler: { [unowned self] (action, indexPath) in
            self.untopChannel(atIndexPath: indexPath)
        })
        return untopRowAction
    }()
    
    lazy var unfollowRowAction: UITableViewRowAction = {
        let unfollowRowAction: UITableViewRowAction = UITableViewRowAction(style: .destructive, title: "取消关注", handler: { [unowned self] (action, indexPath) in
            self.unfollowChannel(atIndexPath: indexPath)
        })
        return unfollowRowAction
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        AccountService.default.loginWithTel("15375496301", password: "123456", telCode: "+86") { (path, response, error) in
        }
        
        setupUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: kZingFollowedChannelUpdated, object: nil)
    }

    deinit {
        if isViewLoaded {
            NotificationCenter.default.removeObserver(self, name: kZingFollowedChannelUpdated, object: nil);
        }
    }
}

//MARK: - UI界面相关
extension ChannelViewController {
    func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    func reloadTableView(_ notification: Notification) {
        mainQueue.async {
            self.tableView.reloadData()
        }
    }
    
    func topChannel(atIndexPath indexPath: IndexPath) {
        let channel = getChannel(withIndexPath: indexPath)!
        ZingFollowedChannel.default.top(channelId: channel.id_p)
        APIService.default.post(.channelTopping, parameters: ["channelId": channel.id_p], queue: userInitiatedQueue)
    }
    
    func untopChannel(atIndexPath indexPath: IndexPath) {
        let channel = getChannel(withIndexPath: indexPath)!
        ZingFollowedChannel.default.untop(channelId: channel.id_p)
        APIService.default.post(.channelUntop, parameters: ["channelId": channel.id_p], queue: userInitiatedQueue)
    }
    
    func unfollowChannel(atIndexPath indexPath: IndexPath) {
        let channel = getChannel(withIndexPath: indexPath)!
        ZingFollowedChannel.default.unfollow(channelId: channel.id_p)
        APIService.default.post(.channelUnfollow, parameters: ["channelId": channel.id_p], queue: userInitiatedQueue)
    }
    
    private func getChannel(withIndexPath indexPath: IndexPath) -> ZTMChannel? {
        if let cell = tableView.cellForRow(at: indexPath) as? ChannelListCell {
            return cell.channel
        }
        return nil
    }
}

//MARK: - tableView 代理、数据源
extension ChannelViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            return ZingFollowedChannel.default.toppingChannels?.count ?? 0
        case 2:
            return ZingFollowedChannel.default.followedChannels?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let CellID = "CellID"
        var cell = tableView.dequeueReusableCell(withIdentifier: CellID) as? ChannelListCell
        
        if cell == nil {
            cell = ChannelListCell(style: .default, reuseIdentifier: CellID)
        }
        switch indexPath.section {
        case 1:
            cell?.channel = ZingFollowedChannel.default.toppingChannels?[indexPath.row]
        case 2:
            cell?.channel = ZingFollowedChannel.default.followedChannels?[indexPath.row]
        default:
            cell?.channel = nil
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            return (ZingFollowedChannel.default.toppingChannels?.count ?? 0) > 0 ? "置顶频道" : ""
        case 2:
            return (ZingFollowedChannel.default.followedChannels?.count ?? 0) > 0 ? "关注频道" : ""
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(SensesViewController(), animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        switch indexPath.section {
        case 1:
            return [unfollowRowAction, untopRowAction]
        case 2:
            return [unfollowRowAction, topRowAction]
        default:
            return []
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }
}

class ChannelListCell: UITableViewCell {
    var channel: ZTMChannel! {
        didSet {
            self.textLabel?.text = channel.name
        }
    }
}
