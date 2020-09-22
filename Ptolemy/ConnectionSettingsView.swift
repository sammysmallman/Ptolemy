//
//  ConnectionSettingsView.swift
//  Ptolemy
//
//  Created by Sam Smallman on 20/09/2020.
//

import SwiftUI

struct ConnectionSettingsView: View {
    @Binding var isPresented: Bool

    @State private var ipAddress: String = UserDefaults.standard.string(forKey: UserDefaultKeys.ipAddress) ?? ""
    @State private var receivePortNumber: String = UserDefaults.standard.string(forKey: UserDefaultKeys.receivePortNumber) ?? "0"
    @State private var sendPortNumber: String = UserDefaults.standard.string(forKey: UserDefaultKeys.sendPortNumber) ?? "0"
    @State private var useTCP = UserDefaults.standard.bool(forKey: UserDefaultKeys.useTCP) == true ? 1 : 0
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("IP Address")
                    .font(.footnote)
                    .textCase(.uppercase)
                TextField(ipAddress, text: $ipAddress)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                if useTCP == 0 {
                    Text("Send Port")
                        .font(.footnote)
                        .textCase(.uppercase)
                        .padding(.top, 10)
                    TextField(sendPortNumber, text: $sendPortNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    Text("Receive Port")
                        .font(.footnote)
                        .textCase(.uppercase)
                        .padding(.top, 10)
                    TextField(receivePortNumber, text: $receivePortNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                } else {
                    Text("Port")
                        .font(.footnote)
                        .textCase(.uppercase)
                        .padding(.top, 10)
                    TextField(sendPortNumber, text: $sendPortNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                Picker(selection: $useTCP, label: Text("What is the connection Type?")) {
                    Text("TCP").tag(1)
                    Text("UDP").tag(0)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.top, 10)
            }

            .padding()
            .navigationBarTitle("Connection", displayMode: .inline)
            .navigationBarItems(
                leading:
                    Button("Cancel") {
                        isPresented = false
                    },
                trailing:
                    Button("Save") {
                        UserDefaults.standard.set(ipAddress, forKey: UserDefaultKeys.ipAddress)
                        UserDefaults.standard.set(sendPortNumber, forKey: UserDefaultKeys.sendPortNumber)
                        UserDefaults.standard.set(receivePortNumber, forKey: UserDefaultKeys.receivePortNumber)
                        UserDefaults.standard.set(useTCP, forKey: UserDefaultKeys.useTCP)
                        isPresented = false
                    }
            )
        }
    }
}

struct ConnectionSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionSettingsView(isPresented: .constant(true))
    }
}
