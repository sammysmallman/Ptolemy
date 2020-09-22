//
//  TabNavigationView.swift
//  Ptolemy
//
//  Created by Sam Smallman on 20/09/2020.
//

import SwiftUI

struct TabNavigationView: View {
    var body: some View {
        TabView {
            NavigationView {
                PacketViewNavigation()
            }
            .tabItem {
                Image(systemName: "cube.box").imageScale(.large)
                Text("Packets")
            }
            NavigationView {
                AutomationView()
            }
            .tabItem {
                Image(systemName: "timelapse").imageScale(.large)
                Text("Automation")
            }
        }
    }
}

struct TabNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        TabNavigationView()
    }
}
