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
    @EnvironmentObject var accumulator: FamilyAccumulator
    @Environment(\.presentationMode) var presentationMode
    @Binding var linkSelection: String?

    var body: some View {
        VStack {
            //If SwiftUI supported a switch here, that would be the right thing to use.
            if accumulator.phase == .transaction {
                FamilyJoinTransactionPhaseView()
            } else if accumulator.phase == .head {
                FamilyJoinHeadPhaseView()
            } else if accumulator.phase == .household {
                FamilyJoinHouseholdPhaseView()
            } else if accumulator.phase == .reset {
                Text("reset phase").onAppear() {
                    NSLog("FJV in phase reset")
                    self.accumulator.reset()
                    self.linkSelection = nil
                    self.presentationMode.wrappedValue.dismiss()
                }
            } else {
                Text("Oops!")
            }
        }
    }
}

//struct FamilyJoinView_Previews: PreviewProvider {
//    static var previews: some View {
//        FamilyJoinView()
//    }
//}
