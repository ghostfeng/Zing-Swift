//
//  APIService.swift
//  Zing-Swift
//
//  Created by 刘永峰 on 2017/4/9.
//  Copyright © 2017年 Witgo. All rights reserved.
//

import Foundation
import Alamofire
import ZingPBModel

public typealias PBClosure = (String, ZTMZingResponse?, Error?) -> Void
public typealias JSONClosure = (String, Any?, Error?) -> Void

let BASE_URL_SERVICES = "/services"
let APIServiceFailure = NSNotification.Name(rawValue: "APIServiceFailure")
let APIServiceDataFailure = NSNotification.Name(rawValue: "APIServiceDataFailure")


/// 网络请求服务类
class APIService {
    private static let INSTANCE = APIService()
    let getManager: Alamofire.SessionManager
    let postManager: Alamofire.SessionManager
    let networkReachabilityManager: Alamofire.NetworkReachabilityManager
    var networkStatus: Alamofire.NetworkReachabilityManager.NetworkReachabilityStatus = .unknown
    
    /// 获取网络请求服务类
    class var `default`: APIService {
        return INSTANCE
    }
    
    private init() {
        var config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        config.httpShouldUsePipelining = true
        config.timeoutIntervalForResource = 12
        postManager = Alamofire.SessionManager(configuration: config)
        
        config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        config.httpShouldUsePipelining = true
        config.timeoutIntervalForResource = 6
        getManager = Alamofire.SessionManager(configuration: config)
        networkReachabilityManager = Alamofire.NetworkReachabilityManager()!
        networkReachabilityManager.listener = {status in
            self.networkStatus = status
            switch status {
            case .unknown:
                print("net unknown!")
            case .notReachable:
                print("net notReachable!")
            case .reachable(let type):
                print("net reachableIn(\(type))")
            }
        }
        networkReachabilityManager.startListening()
    }
    
    private var headers: HTTPHeaders = ["X-Zing-PageSize": String(30)]
    private let acm = AppConfigManager.defaultManager
    var pageSize: Int = 30 {
        didSet{
            headers["X-Zing-PageSize"] = String(pageSize)
        }
    }
    var token: String? = nil {
        didSet {
            headers["X-Zing-Ts"] = token
        }
    }
    
    static let EMPTY_PBCLOSURE = {(path: String, response: ZTMZingResponse?, error: Error?) -> Void in
        #if DEBUG
            if let error = error {
                print(path, "APIService error", error)
            }
            if let response = response, response.code != 0 {
                print(path, "APIService API error")
            }
        #endif
    }
    
    private func getAbsolutePath(_ path: String) -> String {
        if path.hasPrefix("http") {
            return path
        } else {
            return acm.apiUrl + BASE_URL_SERVICES + path
        }
    }
    
    func get(_ path: String, parameters: [String: String] = [:], queue: DispatchQueue? = nil, closure: @escaping PBClosure) {
        headers["X-Zing-At"] = String(Date().timeIntervalSince1970 * 1000)
        getManager.request(path, method: .get, parameters: parameters, headers: headers).validate().responseData(queue: queue) { (responseData) in
            switch responseData.result {
            case .failure(let error):
                NotificationCenter.default.post(name: APIServiceFailure, object: self, userInfo: ["error": error])
                closure(path, nil, error)
                break
            case .success(let data):
                do {
                    let response = try ZTMZingResponse(data: data)
                    #if DEBUG
                        print("API 性能", path, UInt64(Date().timeIntervalSince1970 * 1000) - response.requestAt, response.duration)
                    #endif
                    closure(path, response, nil)
                } catch {
                    NotificationCenter.default.post(name: APIServiceDataFailure, object: self, userInfo: ["error": error, "path": path])
                    closure(path, nil, error)
                }
                break
            }
        }
    }
    
    func get(_ path: RequestPath, pathParameters: [String: String] = [:], queue: DispatchQueue? = nil, closure: @escaping PBClosure) {
        get(getAbsolutePath(path.rawValue), parameters: pathParameters, queue: queue, closure: closure)
    }
    
    func post(_ path: String, parameters: [String: String] = [:], queue: DispatchQueue? = nil, closure: @escaping PBClosure) {
        headers["X-Zing-At"] = String(Date().timeIntervalSince1970 * 1000)
        getManager.request(path, method: .post, parameters: parameters, headers: headers).validate().responseData(queue: queue) { (responseData) in
            switch responseData.result {
            case .failure(let error):
                NotificationCenter.default.post(name: APIServiceFailure, object: self, userInfo: ["error": error])
                closure(path, nil, error)
                break
            case .success(let data):
                do {
                    let response = try ZTMZingResponse(data: data)
                    #if DEBUG
                        print("API 性能", path, UInt64(Date().timeIntervalSince1970 * 1000) - response.requestAt, response.duration)
                    #endif
                    closure(path, response, nil)
                } catch {
                    NotificationCenter.default.post(name: APIServiceDataFailure, object: self, userInfo: ["error": error, "path": path])
                    closure(path, nil, error)
                }
                break
            }
        }
    }
    
    func post(_ path: RequestPath, parameters: [String: String] = [:], queue: DispatchQueue? = nil, closure: @escaping PBClosure) {
        post(getAbsolutePath(path.rawValue), parameters: parameters, queue: queue, closure: closure)
    }
    
}
