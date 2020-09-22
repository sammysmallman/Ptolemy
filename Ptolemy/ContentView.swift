//
//  ContentView.swift
//  Ptolemy
//
//  Created by Sam Smallman on 20/09/2020.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        if sizeClass == .compact {
            TabNavigationView()
        } else {
            SideBarNavigation()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
