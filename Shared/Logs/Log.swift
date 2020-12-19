//
//  Log.swift
//  Stamp Tub
//
//  Created by Sam Smallman on 09/12/2020.
//

import SwiftUI
import TailwindCSSColors

struct Log: Identifiable {
    
    enum Category: String {
        case error = "Error"
        case information = "Info"
        case input = "Input"
        case output = "Output"
    }
    
    let id = UUID()
    let timestamp = Date()
    let string: String
    let category: Category
    
    var categoryColorLight: Color {
        switch category {
        case .error: return Color(Tailwind.color(.red500))
        case .information: return Color(Tailwind.color(.purple500))
        case .input: return  Color(Tailwind.color(.blue500))
        case .output: return Color(Tailwind.color(.green500))
        }
    }
    
    var categoryColorDark: Color {
        switch category {
        case .error: return Color(Tailwind.color(.red400))
        case .information: return Color(Tailwind.color(.purple400))
        case .input: return  Color(Tailwind.color(.blue400))
        case .output: return Color(Tailwind.color(.green400))
        }
    }
    
    static func dateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:m:ss.SSS"
        return formatter
    }
    
    // MARK:- Example Log for SwiftUI Previews
    static var example: Log {
        Log(string: "/example", category: .input)
    }
    
}
