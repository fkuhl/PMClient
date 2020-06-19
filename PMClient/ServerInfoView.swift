//
//  ServerInfoView.swift
//  PMClient
//
//  Created by Frederick Kuhl on 6/19/20.
//  Copyright © 2020 TyndaleSoft LLC. All rights reserved.
//

import SwiftUI

struct ServerInfoView: View {
    @State var host = "localhost"
    @State var port = "8000"
    @Binding var serverSheetIsPresented: Bool
    
    var body: some View {
        ZStack {
            Image("papyrus").resizable().frame(width:500, height: 600)
            VStack {
                Text("Server Information:").font(.title).foregroundColor(Color.primary).padding()
                HStack(alignment: .lastTextBaseline) {
                    Text("Host:")
                        .frame(width: 70, alignment: .trailing)
                        .font(.body)
                    TextField("Host", text: $host)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 200, alignment: .leading)
                        .font(.body)
                }
                HStack(alignment: .lastTextBaseline) {
                    Text("Port:")
                        .frame(width: 70, alignment: .trailing)
                        .font(.body)
                    TextField("Port", text: $port)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 200, alignment: .leading)
                        .font(.body)
                }
                HStack {
                    Spacer()
                    Button(action: {
                        DataFetcher.dataServerHost = self.host
                        DataFetcher.dataServerPort = Int(self.port) ?? 8000 //nasty!
                        DataFetcher.sharedInstance.fetch()
                        self.$serverSheetIsPresented.wrappedValue = false
                    }) {
                        Image(systemName: "arrow.right.square.fill").imageScale(.large)
                    }.padding(.top, 20)
                        .disabled(host.isEmpty || Int(port) == nil)
                }.frame(maxWidth: 270)
            }.padding().background(RoundedRectangle(cornerRadius: 5).opacity(0.3))
        }
    }
}

struct ServerInfoView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ServerInfoView(serverSheetIsPresented: .constant(true))
            .previewLayout(.sizeThatFits)
            .padding()
                .background(Color(.systemBackground))
                .environment(\.colorScheme, .light)
            .previewDisplayName("Light")
            
            ServerInfoView(serverSheetIsPresented: .constant(true))
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color(.systemBackground))
            .environment(\.colorScheme, .dark)
            .previewDisplayName("Dark")
        }
    }
}
