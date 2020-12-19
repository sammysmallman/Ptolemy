//
//  LogsHeaderView.swift
//  Stamp Tub
//
//  Created by Sam Smallman on 09/12/2020.
//

import SwiftUI

struct LogsHeaderView: View {
    
    @Binding var logs: [Log]
    
    var body: some View {
        NavigationLink(destination: LogsView(logs: $logs)) {
            HStack {
                Text("Logs")
                Spacer()
                Text("\(logs.count)")
                Image(systemName: "chevron.right")
                    .imageScale(.large)
            }
        }
        .padding(.bottom, 10)
    }
}

struct LogsHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        LogsHeaderView(logs: Binding.constant([Log.example]))
    }
}
