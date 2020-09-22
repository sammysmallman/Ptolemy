//
//  PacketsView.swift
//  Ptolemy
//
//  Created by Sam Smallman on 20/09/2020.
//

import SwiftUI

struct PacketViewNavigation: View {
    @State var connectionSettingsIsPresented = false
    
    var body: some View {
        return PacketsView()
            .navigationBarItems(trailing:
                Button(action: {
                    self.connectionSettingsIsPresented.toggle()
                }) {
                    Image(systemName: "wifi").imageScale(.large)
                }.sheet(isPresented: $connectionSettingsIsPresented, content: {
                    ConnectionSettingsView(isPresented: $connectionSettingsIsPresented)
                })
            )
    }
}

struct PacketsView: View {
    @State var showingDetail = false
    var body: some View {
        Text("Packets View")
    }
}

struct PacketsView_Previews: PreviewProvider {
    static var previews: some View {
        PacketsView()
    }
}
