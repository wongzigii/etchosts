//
//  EtcHostsTests.swift
//  EtcHostsTests
//
//  Created by Wong Zigii on 2017/2/12.
//  Copyright © 2017年 Zigii Wong. All rights reserved.
//

import XCTest
import EtcHosts

class EtcHostsTests: XCTestCase {
    
    var configuration: EtcHostsConfiguration!
    
    override func setUp() {
        super.setUp()
        self.configuration = EtcHostsConfiguration()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInstanceNotNil() {
        XCTAssertNotNil(configuration)
    }
    
    func testDefaultToHostIfNoOverridingAddress() {
        let host = URL(string: "https://google.com")?.host
        let address = configuration.IPAddressForHostName(host!)
        XCTAssertEqual(host, address, "The address should be identical to the URL host if no overrides are supplied")
    }
    
    func testAddressForHostOverride() {
        let overrideAddress = "192.168.0.1"
        let originURL = URL(string: "https://google.com")!
        let originHost = originURL.host!
        configuration.resolveHostName(hostname: originHost, to: overrideAddress)
        let newAddress = configuration.IPAddressForHostName(originHost)
        XCTAssertEqual(newAddress, overrideAddress, "The address should be overridden")
    }
    
}
