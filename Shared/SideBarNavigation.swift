//
//  SideBarNavigation.swift
//  Ptolemy
//
//  Created by Sam Smallman on 28/09/2020.
//

import SwiftUI

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
                }
                NavigationLink(destination: AutomationsView(), tag: Selection.automations, selection: optionalCurrentSelection) {
                    Label("Automations", systemImage: "goforward")
                }
            }
            .listStyle(SidebarListStyle())
            
            .toolbar {
                #if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Section(header: Text("Units")) {
//                            MeasurementUnitsPicker()
                        }

//                        CloudCoverageToggle()
                    }
                    label: {
                        Label("Settings", systemImage: "gearshape")
                    }
                }
                #endif
            }
            
            Text("No Selection")
        }
    }
    
}
