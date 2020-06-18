//
//  ContentView.swift
//  PMClient
//
//  Created by Frederick Kuhl on 12/19/19.
//  Copyright © 2019 TyndaleSoft LLC. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            MembersView()
                .font(.title)
                .tabItem {
                    Image(systemName: "person.2.fill")
                    Text("Members")
                }
                .tag(0)
            HouseholdsView()
                .font(.title)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Households")
                }
                .tag(1)
            DataTransactionsView()
                .font(.title)
                .tabItem {
                    Image(systemName: "pencil.circle")
                    Text("DB Transactions")
                }
                .tag(2)
            QueriesView()
                .font(.title)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Queries")
                }
                .tag(3)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

let defaultCaptionWidth: CGFloat = 150
