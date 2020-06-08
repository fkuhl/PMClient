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
                HouseholdView(item: dataFetcher.addedHousehold!, removeButtons: true)
            } else {
                Text("Waiting for new household to be added...")
            }
        }
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
