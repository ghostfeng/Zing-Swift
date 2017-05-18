//
//  LocalizedContext.swift
//  ZingCommon
//
//  Created by 刘永峰 on 2017/5/18.
//  Copyright © 2017年 Witgo. All rights reserved.
//

import UIKit


public class LocalizedContext: NSObject {
    static let INSTANCE = LocalizedContext()
    
    private override init() {
        super.init()
    }
    
    public class var `default`: LocalizedContext {
        return INSTANCE
    }
    
    //当前语言Bundle
    private let kUserLanguage = "AppleLanguages"
    internal var currentLanguageBundle:Bundle?
    
    //当前语言
    fileprivate var _currentLanguage:String?
    var currentLanguage: String {
        get {
            if _currentLanguage == nil {
                _currentLanguage = (UserDefaults.standard.value(forKey: kUserLanguage) as! Array<String>).first
            }
            return _currentLanguage!
        }
        set {
            if _currentLanguage != newValue {
                if let path = Bundle.main.path(forResource: newValue, ofType: "lproj"), let bundle = Bundle(path: path) {
                    _currentLanguage = newValue
                    currentLanguageBundle = bundle
                } else {
                    //如果不支持当前语言则加载info中Localization native development region中的值的lporj
                    let defaultLanguage = (Bundle.main.infoDictionary! as NSDictionary).value(forKey: kCFBundleDevelopmentRegionKey as String) as! String
                    _currentLanguage = defaultLanguage
                    currentLanguageBundle = Bundle(path: Bundle.main.path(forResource: defaultLanguage, ofType: "lproj")!)
                }
                let def = UserDefaults.standard
                def.setValue([_currentLanguage!], forKey:kUserLanguage)
                def.synchronize()
            }
        }
    }
    
    /**
     获取当前语言的storyboard
     */
    func storyboard(_ name:String) -> UIStoryboard{
        return UIStoryboard(name: name, bundle: self.currentLanguageBundle)
    }
    
    /**
     获取当前语言的nib
     */
    func nib(_ name:String) -> UINib{
        return UINib(nibName: name, bundle: self.currentLanguageBundle)
    }
    
    /**
     获取当前语言的string
     */
    func string(_ key:String) -> String {
        if let str = currentLanguageBundle?.localizedString(forKey: key, value: nil, table: nil){
            return str
        }
        return key
    }
}

public func localized(_ key:String) -> String {
    return LocalizedContext.default.string(key)
}
