//
//  OSCConnectionView.swift
//  Stamp Tub
//
//  Created by Sam Smallman on 09/12/2020.
//

import SwiftUI

struct OSCConnectionView: View {
    
    static let dateFormatter = Log.dateFormatter()
    
    @ObservedObject var connection = OSCConnection()
    @State private var oscPacket: String = ""
    
    var body: some View {
        Form {
            Section {
                TextField("IP Address", text: $connection.ipAddress)
                    .disabled(connection.isConnected)
                Picker(selection: $connection.type, label: Text("Protocol")) {
                    ForEach(0 ..< OSCConnection.types.count) {
                        Text(OSCConnection.types[$0].string).tag($0)
                    }
                }
                .disabled(connection.isConnected)
            }
            if $connection.type.wrappedValue == 1 {
                Section(footer: OSCVersionFooterView()) {
                    TextField("Port", text: $connection.txPort)
                        .disabled(connection.isConnected)
                        .keyboardType(.numberPad)
                    Picker(selection: $connection.format, label: Text("OSC Version")) {
                        ForEach(0 ..< OSCConnection.formats.count) {
                            Text(OSCConnection.formats[$0].string).tag($0)
                        }
                    }
                    .disabled(connection.isConnected)
                }
            } else {
                Section {
                    TextField("Transmit Port", text: $connection.txPort)
                        .keyboardType(.numberPad)
                        .disabled(connection.isConnected)
                    TextField("Receive Port", text: $connection.rxPort)
                        .keyboardType(.numberPad)
                        .disabled(connection.isConnected)
                }
            }
            
            if !connection.logs.isEmpty {
                Section(header: LogsHeaderView(logs: $connection.logs)) {
                    ForEach(connection.logs.suffix(5)) { log in
                        LogRowView(log: log, dateFormatter: Self.dateFormatter)
                    }
                }
            }

            Section {
                ZStack(alignment: .leading) {
                    if oscPacket.isEmpty {
                        Text("An OSC Annotation...")
                            .keyboardType(.asciiCapable)
                            .font(.body)
                            .padding(.leading, 4)
                            .foregroundColor(Color.secondary)
                    }
                    TextEditor(text: $oscPacket)
                        .keyboardType(.asciiCapable)
                        .font(.body)
                }
                    
                HStack(alignment: .center) {
                    Spacer()
                    Button("Send Packet", action: {
                        connection.send(packet: oscPacket)
                    })
                    .foregroundColor(connection.isConnected ? .white : .black)
                    .disabled(!connection.isConnected)
                    Spacer()
                }
                .listRowBackground(connection.isConnected ? Theme.tintColour : Theme.tintColourSecondary)
            }
        }
        .navigationBarTitle("Ptolemy")
        .navigationBarItems(trailing:
            Button(connection.isConnected ? "Disconnect" : "Connect") {
                connection.isConnected ? connection.disconnect() : connection.connect()
            }
        )
    }
    
}

struct OSCConnection_Previews: PreviewProvider {
    static var previews: some View {
        OSCConnectionView()
    }
}
