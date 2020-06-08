//
//  PhaseTwoView.swift
//  PMClient
//
//  Created by Frederick Kuhl on 6/5/20.
//  Copyright © 2020 TyndaleSoft LLC. All rights reserved.
//

import SwiftUI
import PMDataTypes

struct FamilyJoinOthersPhaseView: View {
    
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var accumulator: FamilyAccumulator
    @ObservedObject var dataFetcher = DataFetcher.sharedInstance
    
    var body: some View {
        VStack {
            if dataFetcher.addedHousehold != nil {
                HouseholdView(item: dataFetcher.addedHousehold!)
            } else {
                Text("new id not found")
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
