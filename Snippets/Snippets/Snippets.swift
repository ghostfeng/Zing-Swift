//
//  Snippets.swift
//  Snippets
//
//  Created by 刘永峰 on 2017/4/27.
//  Copyright © 2017年 Witgo. All rights reserved.
//

import Foundation

public extension UIDevice {
    public class func unameMachine() -> String {
        var systemInfo: utsname = Darwin.utsname()
        _ = Darwin.uname(&systemInfo)
        return String(cString: UnsafeMutableRawPointer(&systemInfo.machine).assumingMemoryBound(to: CChar.self), encoding: .utf8)!
    }
}
