//
//  TransactionsView.swift
//  PMClient
//
//  Created by Frederick Kuhl on 3/20/20.
//  Copyright © 2020 TyndaleSoft LLC. All rights reserved.
//

import SwiftUI

struct TransactionsView: View {
    //@State private var list = Bundle.main.decode([Section].self, from: "TransactionList.json")
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Families")) {
                    NavigationLink(destination: FamilyInitialEntryView()) {
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
    }
}

struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView()
    }
}
