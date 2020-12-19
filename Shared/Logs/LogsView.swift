//
//  LogsView.swift
//  Stamp Tub
//
//  Created by Sam Smallman on 09/12/2020.
//

import SwiftUI

struct LogsView: View {
    
    static let dateFormatter = Log.dateFormatter()
    
    @Binding var logs: [Log]
    
    var body: some View {
        List {
            ForEach(logs) { log in
                LogRowView(log: log, dateFormatter: Self.dateFormatter)
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Logs")
        .navigationBarItems(trailing:
            Button("Clear All") {
                logs.removeAll()
            }
        )
    }
    
}

struct LogsView_Previews: PreviewProvider {
    static var previews: some View {
        LogsView(logs: Binding.constant([
            Log(string: "An error message", category: .error),
            Log(string: "An informative message", category: .information),
            Log(string: "An input message", category: .input),
            Log(string: "An output message", category: .output)
        ]))
    }
}
