//
//  WebViewController.swift
//  Zing-Swift
//
//  Created by 刘永峰 on 2017/5/10.
//  Copyright © 2017年 Witgo. All rights reserved.
//

import UIKit
import WebKit

import ZingCommon

class WebViewController: UIViewController {
    
    let url: URL
    let web = WKWebView()
    let progress = UIProgressView()
    
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        web.addObserver(self, forKeyPath: #keyPath(WKWebView.title), options: .new, context: nil)
        web.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        view.addSubview(web)
        web.load(URLRequest(url: url))
        
        progress.progressTintColor = UIColor.red
        progress.trackTintColor = UIColor.clear
        view.addSubview(progress)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(WKWebView.title) {
            title = web.title
        } else if keyPath == #keyPath(WKWebView.estimatedProgress) {
            progress.alpha = 1
            progress.setProgress(Float(web.estimatedProgress), animated: true)
            if web.estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.3, animations: { 
                    self.progress.alpha = 0
                }, completion: { (success) in
                    self.progress.setProgress(1, animated: false);
                })
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        progress.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 2)
        web.frame = view.bounds
    }

    deinit {
        if isViewLoaded {
            web.removeObserver(self, forKeyPath: #keyPath(WKWebView.title))
            web.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
        }
    }
}
