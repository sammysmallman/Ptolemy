//
//  SideBarNavigation.swift
//  Ptolemy
//
//  Created by Sam Smallman on 20/09/2020.
//

import SwiftUI

struct SideBarNavigation: View {
    @State private var selection: String? = "Packets"
    let name = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: PacketViewNavigation(),
                    label: {
                        Label("Packets", systemImage: "cube.box")
                    })
                    .tag("Packets")
                NavigationLink(
                    destination: AutomationView(),
                    label: {
                        Label("Automation", systemImage: "timelapse")
                    })
                    .tag("Automation")
            }
            .navigationTitle(name)
            .listStyle(SidebarListStyle())
        
            PacketViewNavigation()
        }
    }
}

struct SideBarNavigation_Previews: PreviewProvider {
    static var previews: some View {
        SideBarNavigation()
    }
}
