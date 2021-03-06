//
//  UDPViewController.swift
//  SwiftIO
//
//  Created by Jonathan Wight on 5/9/16.
//  Copyright © 2016 schwa.io. All rights reserved.
//

import Cocoa

import SwiftIO
import SwiftUtilities

// Testing: `echo "Hello World" | socat - UDP-DATAGRAM:0.0.0.0:9999,broadcast`

class UDPViewController: NSViewController {

    dynamic var listenerAddressString: String? = "localhost:9999"
    dynamic var echoAddress: String? = "localhost:9999"
    dynamic var echoBody: String? = "Hello world"

    var listener: UDPChannel? = nil

    func startListening() throws {
        guard let addressString = listenerAddressString else {
            return
        }
        let address = try Address(address: addressString, passive: true)
        log?.debug("Listening on: \(address)")
        listener = UDPChannel(label: "udp-listener", address: address) {
            datagram in

            log?.debug("Received datagram from: \(datagram.from)")

            datagram.data.createMap() {
                data, buffer in

                var string = ""
                hexdump(buffer, zeroBased: true, stream: &string)
                log?.debug("Content: \(string)")
            }

            datagram.data
        }

        try listener?.resume()
    }

    func stopListening() throws {
        listener = nil
    }

    @IBAction func mapListenerAddressToIPV4(sender: NSButton) {
        do {
            guard let addressString = listenerAddressString else {
                return
            }
            let address = try Address(address: addressString, mappedIPV4: true)
            listenerAddressString = String(address)
        }
        catch let error {
            presentError(error as NSError)
        }
    }

    @IBAction func startStopListener(sender: SwitchControl) {
        do {
            if sender.on {
                log?.debug("Server start listening")
                try self.startListening()
            }
            else {
                log?.debug("Server stop listening")
                try self.stopListening()
            }
        }
        catch let error {
            presentError(error as NSError)
        }
}

    @IBAction func mapEchoAddressToIPV4(sender: NSButton) {
        do {
            guard let addressString = echoAddress else {
                return
            }
            let address = try Address(address: addressString, mappedIPV4: true)
            echoAddress = String(address)
        }
        catch let error {
            presentError(error as NSError)
        }
    }


    @IBAction func send(sender: NSButton) {
        do {
            guard let addressString = echoAddress else {
                return
            }
            let address = try Address(address: addressString)

            guard let body = echoBody else {
                return
            }

            let data: DispatchData <Void> = try DispatchData(body)

            let callback = {
                (result: Result <Void>) in

                log?.debug(result)
                if case .Failure(let error) = result {
                    dispatch_async(dispatch_get_main_queue()) {
                        self.presentError(error as NSError)
                    }
                }
            }


            if let listener = listener {
                listener.send(data, address: address, callback: callback)
            }
            else {
                UDPChannel.send(data, address: address, queue: dispatch_get_main_queue(), writeHandler: callback)
            }
        }
        catch let error {
            log?.debug(error)
            presentError(error as NSError)
        }


    }
    
    

}
