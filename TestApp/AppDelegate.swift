//
//  AppDelegate.swift
//  TestApp
//
//  Created by Jonathan Wight on 8/8/15.
//
//  Copyright (c) 2014, Jonathan Wight
//  All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  * Redistributions of source code must retain the above copyright notice, this
//    list of conditions and the following disclaimer.
//
//  * Redistributions in binary form must reproduce the above copyright notice,
//    this list of conditions and the following disclaimer in the documentation
//    and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
//  FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
//  DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
//  SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
//  CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
//  OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
//  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


import Cocoa

import SwiftUtilities
import SwiftIO

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(aNotification: NSNotification) {

        var hints = addrinfo()
        hints.ai_family = PF_INET6
        hints.ai_protocol = IPPROTO_TCP
        try! getaddrinfo("2607:f8b0:4007:803:700::", service: "", hints: hints) {
            print($0.memory.ai_addr.memory)
            return true
        }

//        try! Resolver.sharedInstance.readHosts()
//
//        Resolver.sharedInstance.addressesForName("google.com") {
//            result in
//
//            if case .Success(let addresses) = result {
//                print(addresses)
//                print(addresses[1].to_in6_addr()!.words)
//            }
//
//        }

//        print(try! Address("127.0.0.1:1234"))
        let addrs = try! Address.addresses("::1", protocol: .TCP, family: .INET6)
        print(addrs)
//        print(try! Address("[::]:80"))
//        print(try! Address("localhost:80"))


//        let address = try! Address("127.0.0.1:40000")
//        print(address)

//        for (interface, addresses) in try! Address.addressesForInterfaces() {
//            print(interface, addresses)
//        }
//
//        for address in try! Address.addresses("0.0.0.0", port: 12345) {
//            debugPrint(address)
//        }
//
//        for address in try! Address.addresses("::", port: 12345) {
//            debugPrint(address)
//        }

    }
}

//extension Address {
//
//    init(_ string: String) throws {
//
//
//        throw Error.Unimplemented
//
//    }
//
//}
//
