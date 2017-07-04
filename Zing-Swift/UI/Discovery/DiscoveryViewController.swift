//
//  DiscoveryViewController.swift
//  Zing-Swift
//
//  Created by 刘永峰 on 2017/5/10.
//  Copyright © 2017年 Witgo. All rights reserved.
//

import UIKit

import ZingCommon

class DiscoveryViewController: BaseViewController {
    
    lazy var pageVC: UIPageViewController = { [weak self] in
        let pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageVC.dataSource = self
        pageVC.view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        return pageVC
    }()
    
    var vcs: [UIViewController] = [UIViewController]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.addChildViewController(pageVC)
        self.view.addSubview(pageVC.view)
        pageVC.view.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(30)
            make.bottom.trailing.equalToSuperview().offset(-10)
        }
        
        for _ in 0..<5 {
            let vc = ChannelViewController()
            vcs.append(vc)
        }
        
        pageVC.setViewControllers([vcs.first!], direction: .forward, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension DiscoveryViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let now = vcs.index(of: viewController)
        if let now = now {
            if now - 1 < 0 {
                return nil
            } else {
                return vcs[now - 1]
            }
        } else {
            return nil
        }
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let now = vcs.index(of: viewController)
        if let now = now {
            if now + 1 >= vcs.count {
                return nil
            } else {
                return vcs[now + 1]
            }
        } else {
            return nil
        }
    }
}
