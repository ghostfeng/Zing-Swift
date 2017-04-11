//
//  URLService.swift
//  Zing-Swift
//
//  Created by 刘永峰 on 2017/4/9.
//  Copyright © 2017年 Witgo. All rights reserved.
//

import Foundation

func imageUrl(_ url: String) -> URL {
    if url.hasPrefix("http") {
        return URL(string: url)!
    } else if url.hasPrefix("/") {
        return URL(string: url)!
    } else {
        return URL(string: url)!
    }
}

func webUrl(_ url: String) -> URL {
    if url.hasPrefix("http") {
        return URL(string: url)!
    } else if url.hasPrefix("/") {
        return URL(string: url)!
    } else {
        return URL(string: url)!
    }
}
