//
//  EtcHostsConfiguration.swift
//  EtcHost
//
//  Created by Wong Zigii on 2017/2/12.
//  Copyright © 2017年 Zigii Wong. All rights reserved.
//

import Foundation

public protocol EtcHostsConfigurable {
    
    func resolveHostName(hostname: String, to IPAddress: String)
}

public class EtcHostsConfiguration: EtcHostsConfigurable {
    
    public init() {
        self.mutableIPAddressMapping = [String: String]()
    }
    
    internal var mutableIPAddressMapping: [String: String]!
    
    public func IPAddressForHostName(_ host: String) -> String? {
        objc_sync_enter(mutableIPAddressMapping)
        defer { objc_sync_exit(mutableIPAddressMapping)}
        if mutableIPAddressMapping[host] != nil {
            return mutableIPAddressMapping[host]
        }
        return host
    }
    
    public func resolveHostName(hostname: String, to IPAddress: String) {
        objc_sync_enter(mutableIPAddressMapping)
        defer { objc_sync_exit(mutableIPAddressMapping)}
        mutableIPAddressMapping[hostname.lowercased()] = IPAddress
    }
}
