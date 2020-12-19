//
//  LogRowView.swift
//  Stamp Tub
//
//  Created by Sam Smallman on 10/12/2020.
//

import SwiftUI

struct LogRowView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var log: Log
    var dateFormatter: DateFormatter
    
    var body: some View {
        NavigationLink(destination: LogDetailView(log: log)) {
            HStack {
                Text(log.timestamp, formatter: dateFormatter)
                    .foregroundColor(colorScheme == .dark ? log.categoryColorDark : log.categoryColorLight)
                Text(log.string)
                    .lineLimit(1)
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(log.category.rawValue.uppercased())
                    .font(.system(size: 12, design: .monospaced))
                    .lineLimit(1)
                    .frame(width: 50)
                    .padding(.all, 4)
                    .foregroundColor(colorScheme == .dark ? .black : .white)
                    .background(colorScheme == .dark ? log.categoryColorDark : log.categoryColorLight)
                    .cornerRadius(4)
                Spacer()
            }
        }
        .isDetailLink(true)
    }
}

struct LogRowView_Previews: PreviewProvider {
    static var previews: some View {
        LogRowView(log: Log.example, dateFormatter: Log.dateFormatter())
    }
}
