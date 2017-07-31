//
//  ZSegmentMenuViewController.swift
//  Zing-Swift
//
//  Created by 刘永峰 on 2017/7/21.
//  Copyright © 2017年 Witgo. All rights reserved.
//

import UIKit

let reuseIdentifier = "\(ZSegmentCell.self)"

protocol ZSegmentMenuDataSource: NSObjectProtocol {
    func selectedChannels(_ segmentMenu: ZSegmentMenuViewController) -> [String];
    func unSelectedChannels(_ segmentMenu: ZSegmentMenuViewController) -> [String];
}

protocol ZSegmentMenuDelegate: NSObjectProtocol {
    func segmentMenu(_ segmentMenu:ZSegmentMenuViewController, didSelectItemAt indexPath: IndexPath);
}

func textSize(text: String, font: UIFont, maxSize: CGSize) -> CGSize {
    return text.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], attributes: [NSFontAttributeName : font], context: nil).size
}

class ZSegmentMenuViewController: UIViewController {
    
    weak var delegate: ZSegmentMenuDelegate?
    weak var dataSource: ZSegmentMenuDataSource?

    var normalColor: UIColor = UIColor.lightGray
    var selectColor: UIColor = UIColor.red
    var font: UIFont = UIFont.systemFont(ofSize: 16)
    var margin: CGFloat = 16
    
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
        
        collectionView.frame = view.bounds
        collectionView.reloadData()
        if (dataSource?.selectedChannels(self).count)! > 0 {
            let indexPath = IndexPath(item: 0, section: 0)
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        }
    }
}

//MARK: - UICollectionViewDataSource
extension ZSegmentMenuViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (dataSource?.selectedChannels(self).count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ZSegmentCell
        cell.titleLabel.text = dataSource?.selectedChannels(self)[indexPath.item]
        cell.titleLabel.font = font
        cell.normalColor = normalColor
        cell.selectColor = selectColor
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ZSegmentMenuViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: textSize(text: (dataSource?.selectedChannels(self)[indexPath.item])!, font: font, maxSize: CGSize(width: CGFloat.greatestFiniteMagnitude, height: view.frame.height)).width, height: view.frame.height)
    }
}

//MARK: - UICollectionViewDelegate
extension ZSegmentMenuViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        delegate?.segmentMenu(self, didSelectItemAt: indexPath)
    }
}

extension ZSegmentMenuViewController {
    fileprivate func setupUI() {
        view.addSubview(collectionView)
    }
    
    func selectItemAt(indexPath: IndexPath?) {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
}

class ZSegmentCell: UICollectionViewCell {
    var normalColor: UIColor = UIColor.lightGray
    var selectColor: UIColor = UIColor.red
    
    lazy var titleLabel: UILabel = { [weak self] in
        let titleLabel: UILabel = UILabel(frame: (self?.bounds)!)
        return titleLabel
    }()
    
    lazy var line: UIView = { [weak self] in
        let line: UIView = UIView(frame: (self?.bounds)!)
        line.isHidden = true
        return line
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
        contentView.addSubview(titleLabel)
        contentView.addSubview(line)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.frame = bounds
        titleLabel.textColor = isSelected ? selectColor : normalColor
        
        line.backgroundColor = selectColor
        let lineHeight: CGFloat = 2.0
        line.frame = CGRect(x: 0, y: bounds.height - lineHeight - 1, width: bounds.width, height: lineHeight)
    }
    
    override var isSelected: Bool {
        didSet {
            titleLabel.textColor = isSelected ? selectColor : normalColor
            line.isHidden = !isSelected
        }
    }
}
