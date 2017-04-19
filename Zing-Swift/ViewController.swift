//
//  ViewController.swift
//  Zing-Swift
//
//  Created by 刘永峰 on 2017/3/14.
//  Copyright © 2017年 Witgo. All rights reserved.
//

import UIKit
import ZingPBModel

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        APIService.default.get(.appConfig, queue: userInitiatedQueue) { (path, response, error) in
            let acm = AppConfigManager.defaultManager
            acm.update((response?.config)!)
            print(acm.bucket,acm.bucketEndPoint)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

