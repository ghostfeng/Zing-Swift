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

class ChannelViewController: BaseViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: .grouped)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        AccountService.default.loginWithTel("15201420833", password: "123456", telCode: "+86") { (path, response, error) in
        }
        
        setupUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: kZingFollowedChannelUpdated, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableView.frame = view.bounds;
    }
}

//MARK: - UI界面相关
extension ChannelViewController {
    func setupUI() {
        tableView.hideExtraHeader()
        tableView.hideExtraFooter()
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    func reloadTableView(notification: Notification) {
        mainQueue.async {
            self.tableView.reloadData()
        }
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
        var cell = tableView.dequeueReusableCell(withIdentifier: CellID)
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: CellID)
        }
        switch indexPath.section {
        case 1:
            cell?.textLabel?.text = ZingFollowedChannel.default.toppingChannels?[indexPath.row].name
        case 2:
            cell?.textLabel?.text = ZingFollowedChannel.default.followedChannels?[indexPath.row].name
        default:
            cell?.textLabel?.text = ""
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(BaseViewController(), animated: true)
    }
}
