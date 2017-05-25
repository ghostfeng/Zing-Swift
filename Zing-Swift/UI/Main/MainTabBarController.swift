//
//  MainTabBarController.swift
//  Zing-Swift
//
//  Created by 刘永峰 on 2017/4/27.
//  Copyright © 2017年 Witgo. All rights reserved.
//

import UIKit

//let tabControllersItems = [(controller: ChannelNavigationController(rootViewController: ChannelViewController()),
//                            title: "频道",
//                            normalImg: "channel_normal",
//                            selectedImg: "channel_selected"),
//                           
//                           (controller: DiscoveryNavigationController(rootViewController: DiscoveryViewController()),
//                            title: "发现",
//                            normalImg: "channel_normal",
//                            selectedImg: "channel_selected"),
//
//                           (controller: MessageNavigationController(rootViewController: MessageViewController()),
//                            title: "消息",
//                            normalImg: "channel_normal",
//                            selectedImg: "channel_selected"),
//
//                           (controller: MeNavigationController(rootViewController: MeViewController()),
//                            title: "我的",
//                            normalImg: "channel_normal",
//                            selectedImg: "channel_selected")]

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
    
    func setupViewControllers() {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UITabBarControllerDelegate
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
