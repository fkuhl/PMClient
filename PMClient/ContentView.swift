//
//  ContentView.swift
//  PMClient
//
//  Created by Frederick Kuhl on 12/19/19.
//  Copyright © 2019 TyndaleSoft LLC. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var dataFetcher = DataFetcher.sharedInstance
    
    var body: some View {
        HStack {
            MemberListView()
         }
        .environmentObject(dataFetcher)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct MemberListView: View {
    @EnvironmentObject var dataFetcher: DataFetcher
    
    var body: some View {
        //Text("count: \(dataFetcher.members.count)")
        List {
            ForEach(dataFetcher.members, id: \.id) {
                Text($0.value.fullName())
            }
        }
    }
}


struct MemberListView_Previews: PreviewProvider {
    static var previews: some View {
        MemberListView()
    }
}
