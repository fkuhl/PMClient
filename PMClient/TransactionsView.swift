//
//  TransactionsView.swift
//  PMClient
//
//  Created by Frederick Kuhl on 3/20/20.
//  Copyright © 2020 TyndaleSoft LLC. All rights reserved.
//

import SwiftUI

struct TransactionsView: View {
    @ObservedObject var familyAccumulator = FamilyAccumulator()
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Families")) {
                    NavigationLink(destination: FamilyJoinView()) {
                        Text("Family joins").font(.body)
                    }
                }
                Section(header: Text("Miscellaneous")) {
                    NavigationLink(destination: DataCheckerView()) {
                        Text("Data checker").font(.body)
                    }
                }
            }
            .navigationBarTitle("Transaction Types")
            .listStyle(GroupedListStyle())
        }
            //A little odd having this here, but make sense:
            //this object will be referred to throughout the navigation.
        .environmentObject(familyAccumulator)
    }
}

struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView()
    }
}
