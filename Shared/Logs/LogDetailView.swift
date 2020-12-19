//
//  LogDetailView.swift
//  Stamp Tub
//
//  Created by Sam Smallman on 09/12/2020.
//

import SwiftUI

struct LogDetailView: View {
    
    var log: Log
    var body: some View {
        Form {
            Text(log.string)
        }
        .navigationTitle("Log")
    }
}

struct LogDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LogDetailView(log: Log.example)
    }
}
