//
//  ViewController.swift
//  Zing-Swift
//
//  Created by 刘永峰 on 2017/3/14.
//  Copyright © 2017年 Witgo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = APIService.default
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

