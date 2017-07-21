//
//  ZSegmentMenuViewController.swift
//  Zing-Swift
//
//  Created by 刘永峰 on 2017/7/21.
//  Copyright © 2017年 Witgo. All rights reserved.
//

import UIKit

let reuseIdentifier = "\(ZSegmentCell.self)"

class ZSegmentMenuViewController: UIViewController {

    var normalColor: UIColor = UIColor.lightGray
    var selectColor: UIColor = UIColor.red
    var font: UIFont = UIFont.systemFont(ofSize: 16)
    var margin: CGFloat = 16
    
    var dataSource:[String] = ["军事","科技","军事军事新闻","科技","新闻","科技","新闻","科技","新闻","科技","新闻","科技","新闻","科技","新闻"]
    
    lazy var collectionView: UICollectionView = { [weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(0, (self?.margin)!, 0, (self?.margin)!)
        layout.minimumInteritemSpacing = (self?.margin)!
        layout.minimumLineSpacing = (self?.margin)!
        layout.scrollDirection = .horizontal
        let collectionView: UICollectionView = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ZSegmentCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        collectionView.frame = view.bounds;
    }
}

//MARK: - UICollectionViewDataSource
extension ZSegmentMenuViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ZSegmentCell
        cell.titleLabel.text = dataSource[indexPath.row]
        cell.normalColor = normalColor
        cell.selectColor = selectColor
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension ZSegmentMenuViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
}

extension ZSegmentMenuViewController {
    fileprivate func setupUI() {
        view.addSubview(collectionView)
        collectionView.reloadData()
        if dataSource.count > 0 {
            let indexPath = IndexPath(item: 0, section: 0)
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        }
    }
}

class ZSegmentCell: UICollectionViewCell {
    var normalColor: UIColor = UIColor.lightGray
    var selectColor: UIColor = UIColor.red
    
    lazy var titleLabel: UILabel = { [weak self] in
        let titleLabel: UILabel = UILabel(frame: (self?.bounds)!)
        titleLabel.textColor = self?.normalColor
        titleLabel.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    init() {
        super.init(frame: .zero)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupUI()
    }
    
    func setupUI() {
        addSubview(titleLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = bounds
    }
    
    override var isSelected: Bool {
        didSet {
            titleLabel.textColor = isSelected ? selectColor : normalColor
        }
    }
}
