//
//  OSCConnection.swift
//  Stamp Tub
//
//  Created by Sam Smallman on 09/12/2020.
//

import Foundation
import OSCKit

class OSCConnection: ObservableObject {
    
    static let types = [(string: "UDP", useTCP: false), (string: "TCP", useTCP: true)]
    static let formats = [(string: "1.1 - SLIP", format: OSCTCPStreamFraming.SLIP), (string: "1.0 - PLH", format: OSCTCPStreamFraming.PLH)]
    
    @Published var type: Int = UserDefaults.standard.integer(forKey: "type") {
        didSet {
            client.useTCP = OSCConnection.types[type].useTCP
            defaults.set(type, forKey: "type")
        }
    }
    @Published var format: Int = UserDefaults.standard.integer(forKey: "format") {
        didSet {
            client.streamFraming = OSCConnection.formats[format].format
            defaults.set(format, forKey: "format")
        }
    }
    @Published var ipAddress = UserDefaults.standard.string(forKey: "ipAddress") ?? "" {
        didSet {
            client.host = ipAddress
            defaults.set(ipAddress, forKey: "ipAddress")
        }
    }
    @Published var txPort = UserDefaults.standard.string(forKey: "txPort") ?? "" {
        didSet {
            if let port = UInt16(txPort) {
                client.port = port
                defaults.set(txPort, forKey: "txPort")
            } else {
                client.port = 0
                defaults.set(0, forKey: "txPort")
            }
        }
    }
    @Published var rxPort = UserDefaults.standard.string(forKey: "rxPort") ?? "" {
        didSet {
            if let port = UInt16(rxPort) {
                server.port = port
                defaults.set(rxPort, forKey: "rxPort")
            } else {
                server.port = 0
                defaults.set(0, forKey: "rxPort")
            }
        }
    }
    @Published var isConnected: Bool = false
    @Published var logs: [Log] = []
    
    private let defaults = UserDefaults.standard
    private let client = OSCClient()
    private let server = OSCServer()
    
    init() {
        // Setup Client
        client.delegate = self
        client.host = ipAddress
        if let port = UInt16(txPort) {
            client.port = port
        } else {
            client.port = 0
        }
        client.useTCP = OSCConnection.types[type].useTCP
        client.streamFraming = OSCConnection.formats[format].format
        
        // Setup Server
        server.delegate = self
        if let port = UInt16(rxPort) {
            server.port = port
        } else {
            server.port = 0
        }
    }
    
    public func connect() {
        if client.useTCP {
            do {
                try client.connect()
            } catch {
                logs.append(Log(string: "Error: \(error.localizedDescription)", category: .error))
            }
        } else {
            do {
                try server.startListening()
            } catch {
                logs.append(Log(string: "Error: \(error.localizedDescription)", category: .error))
            }
        }
    }
    
    public func disconnect() {
        if client.useTCP {
            client.disconnect()
        } else {
            server.stopListening()
        }
    }
    
    public func send(packet: String) {
        if let message = OSCAnnotation.oscMessage(for: packet, with: .spaces) {
            client.send(packet: message)
            logs.append(Log(string: packet, category: .output))
        } else {
            logs.append(Log(string: "Invalid OSC Annotation: \(packet)", category: .error))
        }
    }
    
}

extension OSCConnection: OSCClientDelegate {
    
    func clientDidConnect(client: OSCClient) {
        logs.append(Log(string: "Connected", category: .information))
        isConnected = true
    }
    
    func clientDidDisconnect(client: OSCClient) {
        logs.append(Log(string: "Disconnected", category: .information))
        isConnected = false
    }

}

extension OSCConnection: OSCPacketDestination {
    
    func take(message: OSCMessage) {
        logs.append(Log(string: message.addressPattern, category: .input))
    }
    
    func take(bundle: OSCBundle) {
        print(bundle.elements.count)
    }
    
}
