//
//  BaseViewController.swift
//  ZingCommon
//
//  Created by 刘永峰 on 2017/5/3.
//  Copyright © 2017年 Witgo. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let prepareSegueWithDatable = segue.destination as? PrepareSegueWithDatable{
            prepareSegueWithDatable.prepareSegueWith(data: sender)
        }
    }
}
