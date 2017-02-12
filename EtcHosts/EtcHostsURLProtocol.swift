//
//  EtcHostsURLProtocol.swift
//  EtcHosts
//
//  Created by Wong Zigii on 2017/2/12.
//  Copyright © 2017年 Zigii Wong. All rights reserved.
//

import Foundation

internal let EtcHostsModifiedPropertyKey = "EtcHostModifiedPropertyKey"

internal let HTTPPrefix = "http"

internal let HTTPSPrefix = "https"

public class EtcHostsURLProtocol: URLProtocol {
    
   	internal var session: URLSession? = URLSession(configuration: .default)
    
    internal var sessionTask: URLSessionTask?
    
    static internal let shareConfiguration = EtcHostsConfiguration()
    
    static public func configureHosts(_ callback: (_ configuration: EtcHostsConfiguration) -> Void) {
        callback(shareConfiguration)
    }
    
    public override class func canInit(with request: URLRequest) -> Bool {

        if let host = request.url?.host, shareConfiguration.IPAddressForHostName(host) != nil {
            if request.url?.scheme?.caseInsensitiveCompare(HTTPPrefix) == .orderedSame || request.url?.scheme?.caseInsensitiveCompare(HTTPSPrefix) == .orderedSame {
                return true
            }
        }
        return false
    }
    
    public override class func canonicalRequest(for request: URLRequest) -> URLRequest {

        if let requestURL = request.url, let host = requestURL.host {
            let host = shareConfiguration.IPAddressForHostName(host)
            if !(requestURL.host == host) && host != nil {
                var component: URLComponents! = URLComponents(url: requestURL, resolvingAgainstBaseURL: false)
                component.host = host
                let mutableRequest = URLRequest(url: component.url!)
                return mutableRequest
            }
        }
        
        return request
    }
    
    public override func startLoading() {
        
        sessionTask = session?.dataTask(with: EtcHostsURLProtocol.canonicalRequest(for: self.request))
        sessionTask?.resume()
    }
    
    public override func stopLoading() {
        
        sessionTask?.cancel()
    }
}

extension EtcHostsURLProtocol: URLSessionTaskDelegate {
    
    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        self.client?.urlProtocolDidFinishLoading(self)
    }
}
