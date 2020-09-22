//
//  Connection.swift
//  Ptolemy
//
//  Created by Sam Smallman on 21/09/2020.
//

import Foundation
import OSCKit

class Connection: NSObject {
    
    private var ipAddress: String
    private var receivePortNumber: UInt16
    private var sendPortNumber: UInt16
    private var useTCP: Bool
    private let keys = [UserDefaultKeys.ipAddress, UserDefaultKeys.receivePortNumber, UserDefaultKeys.sendPortNumber, UserDefaultKeys.useTCP]
    
    private let client = OSCClient()
    private let server = OSCServer()
    
    override init() {
        ipAddress = UserDefaults.standard.string(forKey: UserDefaultKeys.ipAddress) ?? ""
        receivePortNumber = UInt16(UserDefaults.standard.string(forKey: UserDefaultKeys.receivePortNumber) ?? "0") ?? 0
        sendPortNumber = UInt16(UserDefaults.standard.string(forKey: UserDefaultKeys.sendPortNumber) ?? "0") ?? 0
        useTCP = UserDefaults.standard.bool(forKey: UserDefaultKeys.useTCP)
        super.init()
        client.delegate = self
        keys.forEach { UserDefaults.standard.addObserver(self, forKeyPath: $0, options: .new, context: nil) }
    }
    
    deinit {
        keys.forEach { UserDefaults.standard.removeObserver(self, forKeyPath: $0) }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let key = keyPath, keys.contains(key), let userDefaults = object as? UserDefaults else { return }
        disconnect()
        if key == UserDefaultKeys.ipAddress {
            ipAddress = userDefaults.string(forKey: "ipAddress") ?? ""
            print("IP Address: \(ipAddress)")
        }
        if key == UserDefaultKeys.receivePortNumber {
            receivePortNumber = UInt16(userDefaults.string(forKey: "receivePortNumber") ?? "0") ?? 0
            print("Receive Port: \(receivePortNumber)")
        }
        if key == UserDefaultKeys.sendPortNumber {
            sendPortNumber = UInt16(userDefaults.string(forKey: "sendPortNumber") ?? "0") ?? 0
            print("Send Port: \(sendPortNumber)")
        }
        if key == UserDefaultKeys.useTCP {
            useTCP = userDefaults.bool(forKey: "useTCP")
            print("Use TCP \(useTCP)")
        }
        connect()
    }
    
    private func disconnect() {
        server.stopListening()
        if useTCP {
            client.disconnect()
        }
    }
    
    private func connect() {
        do {
            client.host = ipAddress
            client.port = sendPortNumber
            server.port = receivePortNumber
            client.useTCP = useTCP
            if useTCP {
                try client.connect()
                try server.startListening()
            }
        } catch {
            print("Connection Error")
        }
    }
    
}

extension Connection: OSCClientDelegate {

    func clientDidConnect(client: OSCClient) {
        print("Client did Connect")
    }
    
    func clientDidDisconnect(client: OSCClient) {
        print("Client did Disconnect")
    }
    
}

extension Connection: OSCPacketDestination {
    func take(message: OSCMessage) {
        print(OSCAnnotation.annotation(for: message, with: .spaces, andType: true))
    }
    
    func take(bundle: OSCBundle) {
        print("Bundle!")
    }
    
    
}
