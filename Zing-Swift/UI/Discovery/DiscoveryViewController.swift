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
    
    lazy var menu: ZSegmentMenuViewController = { [weak self] in
        let menu = ZSegmentMenuViewController()
        menu.delegate = self
        menu.dataSource = self
        return menu
    }()
    
    var vcs: [UIViewController] = [UIViewController]()
    
    var selectChannels: [String] = ["军事","新闻","科技","段子","图片","视频","音乐","搞笑"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildViewController(menu)
        menu.selectColor = UIColor.red
        menu.normalColor = UIColor.gray
        view.addSubview(menu.view)
        menu.view.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }

        addChildViewController(pageVC)
        view.addSubview(pageVC.view)
        pageVC.view.snp.makeConstraints { (make) in
            make.top.equalTo(menu.view.snp.bottom)
            make.leading.bottom.trailing.equalToSuperview()
        }
        for _ in 0 ..< selectChannels.count {
            let vc = ChannelViewController()
            vcs.append(vc)
        }
        pageVC.setViewControllers([vcs.first!], direction: .reverse, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension DiscoveryViewController: ZSegmentMenuDataSource {
    func unSelectedChannels(_ segmentMenu: ZSegmentMenuViewController) -> [String] {
        return []
    }

    func selectedChannels(_ segmentMenu: ZSegmentMenuViewController) -> [String] {
        return ["军事","新闻","科技","段子","图片","视频","音乐","搞笑"]
    }
}

extension DiscoveryViewController: ZSegmentMenuDelegate {
    func segmentMenu(_ segmentMenu: ZSegmentMenuViewController, didSelectItemAt indexPath: IndexPath) {
        if let index = vcs.index(of: (pageVC.viewControllers?.last)!) {
            pageVC.setViewControllers([vcs[indexPath.item]], direction: indexPath.item > index ? .forward : .reverse, animated: true)
        }
    }
}

extension DiscoveryViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let now = vcs.index(of: viewController)
        if let now = now {
            menu.selectItemAt(indexPath: IndexPath(item: now, section: 0))
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
            menu.selectItemAt(indexPath: IndexPath(item: now, section: 0))
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
