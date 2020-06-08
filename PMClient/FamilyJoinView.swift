//
//  FamilyJoinView.swift
//  PMClient
//
//  Created by Frederick Kuhl on 3/20/20.
//  Copyright © 2020 TyndaleSoft LLC. All rights reserved.
//

import SwiftUI
import PMDataTypes

struct FamilyJoinView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var accumulator: FamilyAccumulator
    @ObservedObject var dataFetcher = DataFetcher.sharedInstance

    var body: some View {
        VStack {
            if accumulator.phase == .transaction {
                FamilyJoinTransactionPhaseView()
            } else if accumulator.phase == .head {
                FamilyJoinHeadPhaseView()
            } else if /*accumulator.phase == .others &&*/ dataFetcher.addedHousehold != nil {
                FamilyJoinOthersPhaseView()
            } else {
                Text("Oops!") // the cases must be exhaustive, right?
            }
        }
    }
}

//struct FamilyInitialEntryView_Previews: PreviewProvider {
//    static var previews: some View {
//        FamilyInitialEntryView()
//    }
//}
