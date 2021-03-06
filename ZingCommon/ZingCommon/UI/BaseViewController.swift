//
//  BaseViewController.swift
//  ZingCommon
//
//  Created by 刘永峰 on 2017/5/3.
//  Copyright © 2017年 Witgo. All rights reserved.
//

import UIKit

open class BaseViewController: UIViewController {

    override open func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        edgesForExtendedLayout = .top
        
        view.backgroundColor = .white
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    override open func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let prepareSegueWithDatable = segue.destination as? PrepareSegueWithDatable{
            prepareSegueWithDatable.prepareSegueWith(data: sender)
        }
    }
}
