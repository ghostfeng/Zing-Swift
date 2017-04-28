//
//  Snippets.swift
//  Snippets
//
//  Created by 刘永峰 on 2017/4/27.
//  Copyright © 2017年 Witgo. All rights reserved.
//

import Foundation

//MARK: - UI
public extension UIDevice {
    public class func unameMachine() -> String {
        var systemInfo: utsname = Darwin.utsname()
        _ = Darwin.uname(&systemInfo)
        return String(cString: UnsafeMutableRawPointer(&systemInfo.machine).assumingMemoryBound(to: CChar.self), encoding: .utf8)!
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

//MARK: - 值
public extension Int32 {
    public static var YES: Int32 { return 1 }
    public static var NO: Int32 { return 0 }
}

public extension UInt32 {
    public static var YES: UInt32 { return 1 }
    public static var NO: UInt32 { return 0 }
}

public extension Int {
    public static var YES: Int { return 1 }
    public static var NO: Int { return 0 }
}
