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
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.keyboardDismissMode = .onDrag
        return tableView
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
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(inputbarVC.view.snp.top)
        }
    }
    
    deinit {
        if isViewLoaded {
            print("sensesVC dealloc")
        }
    }
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
