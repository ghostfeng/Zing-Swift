//
//  MainTabBarController.swift
//  Zing-Swift
//
//  Created by 刘永峰 on 2017/4/27.
//  Copyright © 2017年 Witgo. All rights reserved.
//

import UIKit

import ZingCommon

var tabItems = [(title: "频道",
                 imageName: ZingApplication.tab_channel),
                (title: "发现",
                 imageName: ZingApplication.tab_discovery),
                (title: "消息",
                 imageName: ZingApplication.tab_message),
                (title: "我的",
                 imageName: ZingApplication.tab_me)]

var tabControllers = [ZingApplication.tab_channel: ChannelViewController(),
                      ZingApplication.tab_discovery: DiscoveryViewController(),
                      ZingApplication.tab_message: MessageViewController(),
                      ZingApplication.tab_me: MeViewController()];


class MainTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        setupTabbar()
    }
    
    func setupViewControllers() {
        for item in tabItems {
            if let controller = tabControllers[item.imageName] {
                addChildViewController(controller, title: item.title, imageName: item.imageName)
            }
        }
    }
    
    func setupTabbar() {
        tabBar.tintColor = UIColor.red
        tabBar.backgroundColor = UIColor.white
    }
    
    private func addChildViewController(_ childController: UIViewController, title: String, imageName: String) {
        childController.tabBarItem.image = UIImage(named: imageName + "_normal")
        childController.tabBarItem.selectedImage = UIImage(named: imageName + "_selected")
        childController.tabBarItem.title = title
        childController.title = title
        childController.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.lightGray], for: .normal)
        childController.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.red], for: .selected)
        let nav = BaseNavigationController(rootViewController: childController)
        addChildViewController(nav)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UITabBarControllerDelegate
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
    }
    
    deinit {
        if isViewLoaded {
            
        }
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
