//
//  PhaseTwoView.swift
//  PMClient
//
//  Created by Frederick Kuhl on 6/5/20.
//  Copyright © 2020 TyndaleSoft LLC. All rights reserved.
//

import SwiftUI
import PMDataTypes

struct FamilyJoinHouseholdPhaseView: View {
    @EnvironmentObject var accumulator: FamilyAccumulator
    @ObservedObject var dataFetcher = DataFetcher.sharedInstance

    var body: some View {
        VStack {
            if dataFetcher.addedHousehold != nil {
                HouseholdView(item: dataFetcher.addedHousehold!,
                              replaceButtons: false,
                              spouseFactory: SpouseFactory(household: dataFetcher.addedHousehold!),
                              otherFactory: OtherFactory(household: dataFetcher.addedHousehold!))
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: EmptyView(),
                                    trailing:
                    Button(action: {
                        NSLog("FJHPV close")
                        self.accumulator.phase = .reset
                    }) {
                        Text("Close").font(.body)
                    }
                )
            } else {
                Text("Waiting for new household to be added...")
            }
        }
    }
}

fileprivate class SpouseFactory: HouseholdMemberFactoryDelegate {
    var household: Household
    
    init(household: Household) {
        self.household = household
    }
    
    func make() -> Member {
        var newval = Member()
        NSLog("made spouse \(newval.id)")
        newval.household = self.household.id
        newval.givenName = "Spouse"
        newval.familyName = self.household.head.familyName
        newval.sex = .FEMALE
        newval.maritalStatus = .MARRIED
        newval.spouse = self.household.head.fullName()
        if let trans = self.household.head.transactions.first {
            newval.transactions.append(trans)
        }
        self.household.spouse = newval
        return newval
    }
}

fileprivate class OtherFactory: HouseholdMemberFactoryDelegate {
    var household: Household
    
    init(household: Household) {
        self.household = household
    }
    
    func make() -> Member {
        var newval = Member()
        newval.household = self.household.id
        newval.givenName = "No. \(self.household.others.count + 1)"
        newval.familyName = self.household.head.familyName
        newval.status = .NONCOMMUNING
        if let trans = self.household.head.transactions.first {
            newval.transactions.append(trans)
        }
        newval.father = self.household.head.id
        if let mom = self.household.spouse {
            newval.mother = mom.id
        }
        return newval
    }
}

//fileprivate func newHousehold() -> Household? {
//    return DataFetcher.sharedInstance.householdIndex[DataFetcher.sharedInstance.addedHouseholdId]
//}

//struct PhaseTwoView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhaseTwoView()
//    }
//}
