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
    
    fileprivate var senses:[String] = ["感言0","感言1","感言2","感言3","感言4","感言5","感言6","感言7","感言8","感言9","感言10"];
    
    lazy var inputbarVC: InputBarViewController = { [weak self] in
        let inputbarVC = InputBarWithSpeechViewController()
        inputbarVC.delegate = self
        return inputbarVC
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.keyboardDismissMode = .onDrag
        tableView.delegate = self
        tableView.dataSource = self
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

extension SensesViewController: InputBarDelegate {
    func inputBar(_ inputBar: InputBarViewController, didSendText aText: String) {
        senses.append(aText)
        let indexPath = IndexPath(row: senses.count-1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
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

extension SensesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return senses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "\(UITableViewCell.self)"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
        }
        cell?.textLabel?.text = senses[indexPath.row];
        return cell!
    }
}
