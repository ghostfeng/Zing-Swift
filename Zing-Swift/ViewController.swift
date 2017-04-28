//
//  ViewController.swift
//  Zing-Swift
//
//  Created by 刘永峰 on 2017/3/14.
//  Copyright © 2017年 Witgo. All rights reserved.
//

import UIKit
import ZingPBModel
import Snippets

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        APIService.default.get(.appConfig, queue: userInitiatedQueue) { (path, response, error) in
            let acm = AppConfigManager.default
            if let response = response ,response.code == ZingResponseCode.success.rawValue {
                acm.update(response.config)
            }
            print(acm.bucket,acm.bucketEndPoint)
        }
        
        AccountService.default.loginWithTel("15201420833", password: "123456", telCode: "+86") { (path, response, error) in
            if let response = response {
                print("login:", response)
            }
        }
        
        UMengService.default.getAuthWithUserInfoFromWechat(vc: self) { (response, error) in
            if let error = error {
                print("UMeng getUserInfo error:",error)
                return
            }
            if let response = response {
                print(response)
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
