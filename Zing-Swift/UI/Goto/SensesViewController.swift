//
//  SensesViewController.swift
//  Zing-Swift
//
//  Created by 刘永峰 on 2017/6/15.
//  Copyright © 2017年 Witgo. All rights reserved.
//

import UIKit

import ZingCommon
import SnapKit

class SensesViewController: BaseViewController {
    
    lazy var inputbarVC: InputBarViewController = {
        let inputbarVC = InputBarViewController()
        return inputbarVC
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubviews()
        
        KeyboardService.default.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupSubviews() {
        
        addChildViewController(inputbarVC)
        view.addSubview(inputbarVC.view)
        inputbarVC.view.snp.makeConstraints { (make) in
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
    deinit {
        if isViewLoaded {
            print("sensesVC dealloc")
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

extension SensesViewController: KeyboardServiceDelegate {
    func keyboardFrameChange(withInfo info: KeyboardInfo) {
        inputbarVC.view.snp.updateConstraints { (make) in
            make.bottom.equalTo(view.snp.bottom).offset(-info.height)
        }
        UIView.animate(withDuration: info.duration) { 
            self.view.layoutIfNeeded()
        }
    }
}
