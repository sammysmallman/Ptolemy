//
//  TabNavigation.swift
//  Ptolemy (iOS)
//
//  Created by Sam Smallman on 28/09/2020.
//

import SwiftUI

struct TabNavigation: View {
        
    @Binding var currentSelection: Selection
    
    var body: some View {
        TabView(selection: $currentSelection) {
            PacketsView()
                .tabItem {
                    Label("Packets", systemImage: "cube.box")
                }
                .tag(Selection.packets)
            AutomationsView()
                .tabItem {
                    Label("Automations", systemImage: "goforward")
                }
                .tag(Selection.automations)
        }
    }
}

