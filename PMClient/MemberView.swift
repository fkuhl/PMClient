//
//  MemberView.swift
//  PMClient
//
//  Created by Frederick Kuhl on 12/23/19.
//  Copyright © 2019 TyndaleSoft LLC. All rights reserved.
//

import SwiftUI


struct MemberView: View {
    @EnvironmentObject var memberFetcher: MemberFetcher
    @State private var allOrActive = 0
    @State private var showingAlert = false
    
    var body: some View {
        VStack {
            Picker(selection: $allOrActive,
                   label: Text("What's in a name?"),
                   content: {
                    Text("All Members").tag(0)
                    Text("Active Members").tag(1)
                }).pickerStyle(SegmentedPickerStyle())
            List {
                ForEach(allOrActive == 0 ? memberFetcher.members : memberFetcher.activeMembers, id: \.id) {
                    Text($0.value.fullName())
                }
            }
        }
        .alert(isPresented: $memberFetcher.showingAlert) {
            Alert(title: Text("Failed to fetch Members"),
                  message: Text("\(memberFetcher.fetchError?.errorString ?? "nada")"),
                  dismissButton: .default(Text("OK")))
        }
    }
}



struct MemberView_Previews: PreviewProvider {
    static var previews: some View {
        MemberView().environmentObject(MemberFetcher.mockedInstance)
    }
}
