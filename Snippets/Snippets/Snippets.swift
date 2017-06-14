//
//  Snippets.swift
//  Snippets
//
//  Created by 刘永峰 on 2017/4/27.
//  Copyright © 2017年 Witgo. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

//MARK: - UI
public extension UIDevice {
    public class func unameMachine() -> String {
        var systemInfo: utsname = Darwin.utsname()
        _ = Darwin.uname(&systemInfo)
        return String(cString: UnsafeMutableRawPointer(&systemInfo.machine).assumingMemoryBound(to: CChar.self), encoding: .utf8)!
    }
    
    public class func osVersion() -> String {
        return self.current.systemName + " " + self.current.systemVersion
    }
    
    public class func identifierForVendor() -> String {
        return (self.current.identifierForVendor?.uuidString)!
    }
}

public extension UIImage {
    public class func image(color: UIColor, size:CGSize) -> UIImage?{
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

public extension UIView {
    public func viewController<T: UIViewController>() -> T? {
        var next = self.next
        repeat {
            if next is T {
                return next as! T?
            }
            next = next?.next
        } while (next != nil)
        return nil
    }
}

public extension UIWindow {
    public static let mask = MaskWindow.default
    public class MaskWindow: UIWindow {
        public class var `default`: MaskWindow {
            return INSTANCE
        }
        private static let INSTANCE = MaskWindow()
        private init() {
            super.init(frame: UIScreen.main.bounds)
            backgroundColor = UIColor.black.withAlphaComponent(0.2)
        }
        
        required public init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    public func showMask(withDuration duration: TimeInterval = 0) {
        let mask = UIWindow.mask
        if duration > 0 {
            mask.alpha = 0
        }
        addSubview(mask)
        bringSubview(toFront: mask)
        if duration > 0 {
            UIView.animate(withDuration: duration, animations: { 
                mask.alpha = 1.0
            })
        }
    }
    
    public func dismissMask(withDuration duration: TimeInterval = 0) {
        let mask = UIWindow.mask
        if duration > 0 {
            UIView.animate(withDuration: duration, animations: { 
                mask.alpha = 0
            }, completion: { (finished) in
                if finished {
                    mask.removeFromSuperview()
                }
            })
        } else {
            mask.removeFromSuperview()
        }
    }
}

public extension UIColor {
    public convenience init(rgb: UInt32) {
        self.init(red: CGFloat(rgb >> 16 & 0x0000ff) / 255.0, green: CGFloat(rgb >> 8 & 0x0000ff) / 255.0, blue: CGFloat(rgb & 0x0000ff) / 255.0, alpha: 1.0)
    }
    
    public func toRGB() -> UInt32 {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        getRed(&red, green: &green, blue: &blue, alpha: nil)
        return UInt32(red * 255) << 16 | UInt32(green * 255) << 8 | UInt32(blue * 255)
    }
}

public extension UITableView {
    public func hideExtraHeader() {
        tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNormalMagnitude))
    }
    
    public func hideExtraFooter() {
        tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNormalMagnitude))
    }
}

//MARK: - 值
public extension Int32 {
    public static var `true`: Int32 { return 1 }
    public static var `false`: Int32 { return 0 }
}

public extension UInt32 {
    public static var `true`: UInt32 { return 1 }
    public static var `false`: UInt32 { return 0 }
}
public extension Int64 {
    public static var `true`: Int64 { return 1 }
    public static var `false`: Int64 { return 0 }
}

public extension UInt64 {
    public static var `true`: UInt64 { return 1 }
    public static var `false`: UInt64 { return 0 }
}
public extension Int {
    public static var `true`: Int { return 1 }
    public static var `false`: Int { return 0 }
}

public extension Bundle {
    public class func appVersion() -> String {
        return self.main.infoDictionary!["CFBundleShortVersionString"] as! String
    }
    
    public class func buildVersion() -> String {
        return self.main.infoDictionary!["CFBundleVersion"] as! String
    }
    
    public class func bundleIdentifier() -> String {
        return self.main.infoDictionary![kCFBundleIdentifierKey! as String] as! String
    }
}
