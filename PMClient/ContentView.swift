//
//  ContentView.swift
//  PMClient
//
//  Created by Frederick Kuhl on 12/19/19.
//  Copyright © 2019 TyndaleSoft LLC. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var memberFetcher = MemberFetcher.sharedInstance
    var householdFetcher = HouseholdFetcher.sharedInstance
    var addressFetcher = AddressFetcher.sharedInstance
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            MemberView()
                .font(.title)
                .tabItem {
                    Image(systemName: "person.2.fill")
                    Text("Members")
                }
                .tag(0)
            HouseholdView()
                .font(.title)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Households")
                }
                .tag(1)
        }
        .environmentObject(memberFetcher)
        .environmentObject(householdFetcher)
        .environmentObject(addressFetcher)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
