//
//  PacketsView.swift
//  Ptolemy (iOS)
//
//  Created by Sam Smallman on 28/09/2020.
//

import SwiftUI

struct Packet {
    let id = UUID()
    let title: String
    let message: String
    let imageName = "chevron.left.slash.chevron.right"
}

struct PacketsView: View {
    
    let gridItems = [
        GridItem(.adaptive(minimum: 300, maximum: .infinity), spacing: 20)
    ]
    
    let packets = [Packet(title: "Get Cue List Count", message: "/eos/get/cuelist/count"),
                   Packet(title: "Get Cue List", message: "/eos/get/cuelist/index/*"),
                   Packet(title: "Get Cue Count For List", message: "/eos/get/cue/*/count"),
                   Packet(title: "Get Cue", message: "/eos/get/cue/*/noparts/index/*"),
                   Packet(title: "Get Part Count", message: "/eos/get/cue/*/noparts/index/*"),
                   Packet(title: "Get Part", message: "/eos/get/cue/*/*/index/*")]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItems, alignment: .center, spacing: 20) {
                ForEach(packets, id: \.id) { packet in
                    PacketCell(packet: packet)
                }
                .padding()
            }
        }
            .navigationTitle("Packets")
    }
}

struct PacketsView_Previews: PreviewProvider {
    static var previews: some View {
        PacketsView()
    }
}

struct PacketCell: View {
    
    let packet: Packet
    
    var body: some View {
        GroupBox {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("\(packet.title)")
                        .font(.title3)
                    
                    Text("\(packet.message)")
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Image(systemName: packet.imageName)
                    .font(.system(size: 30))
            }
            .padding()
        }
    }
}
