//
//  OSCVersionFooterView.swift
//  Stamp Tub
//
//  Created by Sam Smallman on 09/12/2020.
//

import SwiftUI

struct OSCVersionFooterView: View {
    var body: some View {
        Text("The OSC version changes the format of packet data. Verify that the server is using the same OSC version number so that packets are read correctly.")
        .font(.footnote)
//        .frame(maxWidth: .infinity)
        .padding(.top, 10)
        .padding(.bottom, 30)
    }
}

struct OSCVersionFooterView_Previews: PreviewProvider {
    static var previews: some View {
        OSCVersionFooterView()
    }
}
