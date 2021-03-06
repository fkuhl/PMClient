//
//  TransactionsView.swift
//  PMClient
//
//  Created by Frederick Kuhl on 3/20/20.
//  Copyright © 2020 TyndaleSoft LLC. All rights reserved.
//

import SwiftUI

fileprivate enum Link: String {
    case familyJoins
    case moveToHousehold
    case dataChecker
}

struct DataTransactionsView: View {
    @ObservedObject var familyAccumulator = FamilyAccumulator()
    @ObservedObject var moveToHouseholdAccumulator = MoveToHouseholdAccumulator()
    @State var linkSelection: String? = nil
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Families")) {
                    NavigationLink(destination: FamilyJoinView(linkSelection: $linkSelection),
                                   tag: Link.familyJoins.rawValue,
                                   selection: $linkSelection) {
                        Button(action: {
                            self.familyAccumulator.reset() //initialize!
                            self.linkSelection = Link.familyJoins.rawValue
                        }) {
                            Text("Family joins").font(.body)
                        }
                    }
                }
                Section(header: Text("Members")) {
                    NavigationLink(destination: MoveToHouseholdView(),
                                   tag: Link.moveToHousehold.rawValue,
                                   selection: $linkSelection) {
                        Button(action: {
                            // TODO initialize move accum
                            self.linkSelection = Link.moveToHousehold.rawValue
                        }) {
                            Text("Member moves to different household").font(.body)
                        }
                    }
                }
                Section(header: Text("Miscellaneous")) {
                    NavigationLink(destination: DataCheckerView(),
                                   tag: Link.dataChecker.rawValue,
                                   selection: $linkSelection) {
                        Button(action: {
                            self.linkSelection = Link.dataChecker.rawValue
                        }) {
                            Text("Data checker").font(.body)
                        }
                    }
                }
            }
            .navigationBarTitle("Transaction Types")
            .listStyle(GroupedListStyle())
        }
            //A little odd having this here, but make sense:
            //this object will be referred to throughout the navigation.
        .environmentObject(familyAccumulator)
        .environmentObject(moveToHouseholdAccumulator)
    }
}

struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        DataTransactionsView()
    }
}
