//
//  AppStyle.swift
//  Zing-Swift
//
//  Created by 刘永峰 on 2017/5/26.
//  Copyright © 2017年 Witgo. All rights reserved.
//

import Foundation
import UIKit

import Snippets

import IQKeyboardManagerSwift

func configAppStyle() {
    UIBarButtonItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.red], for: .normal)
}

public extension IQTextView {
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        if let placeholderLabel = getPrivateProperty(propertyName: "placeholderLabel") as? UILabel {
            placeholderLabel.sizeToFit()
            placeholderLabel.frame = CGRect(x: textContainerInset.left + 4, y: textContainerInset.top, width: self.frame.width - (textContainerInset.left + 4) * 2, height: placeholderLabel.frame.height)
        }
    }
}
