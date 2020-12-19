//
//  SideBarNavigation.swift
//  Ptolemy
//
//  Created by Sam Smallman on 28/09/2020.
//

import SwiftUI
import TailwindCSSColors

struct SidebarNavigation: View {
        
    @Binding var currentSelection: Selection
    
    var optionalCurrentSelection: Binding<Selection?> {
        Binding<Selection?>(
            get: {
                return currentSelection == .none ? nil : currentSelection
            },
            set: { newValue in
                currentSelection = newValue ?? .none
            }
        )
    }
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: PacketsView(), tag: Selection.packets, selection: optionalCurrentSelection) {
                    Label("Packets", systemImage: "cube.box")
                        .foregroundColor(Color(Tailwind.color(.red500)))
                }
                NavigationLink(destination: AutomationsView(), tag: Selection.automations, selection: optionalCurrentSelection) {
                    Label("Automations", systemImage: "goforward")
                }
            }
            .listStyle(SidebarListStyle())
        }
    }
    
}
