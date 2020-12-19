//
//  ContentView.swift
//  Shared
//
//  Created by Sam Smallman on 28/09/2020.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            OSCConnectionView()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
