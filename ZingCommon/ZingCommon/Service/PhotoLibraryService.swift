//
//  PhotoLibraryService.swift
//  ZingCommon
//
//  Created by 刘永峰 on 2017/4/20.
//  Copyright © 2017年 Witgo. All rights reserved.
//

import UIKit

@objc public class PhotoLibraryService: NSObject {
    private static let INSTANCE = PhotoLibraryService()
    
    private override init() {
        super.init()
    }
    
    public class var defaultService: PhotoLibraryService {
        return INSTANCE
    }
    
}
