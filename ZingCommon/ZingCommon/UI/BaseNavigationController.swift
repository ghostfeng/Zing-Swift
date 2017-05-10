//
//  BaseNavigationController.swift
//  ZingCommon
//
//  Created by 刘永峰 on 2017/5/10.
//  Copyright © 2017年 Witgo. All rights reserved.
//

import UIKit

open class BaseNavigationController: UINavigationController {

    override open func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isTranslucent = false
        // Do any additional setup after loading the view.
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override open func pushViewController(_ viewController: UIViewController, animated: Bool) {
        // 仅仅在第一个页面展示底部bar
        viewController.hidesBottomBarWhenPushed = viewControllers.count >= 1
        super.pushViewController(viewController, animated: animated)
    }
    
}
