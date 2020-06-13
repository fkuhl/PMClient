//
//  PhaseOneView.swift
//  PMClient
//
//  Created by Frederick Kuhl on 6/5/20.
//  Copyright © 2020 TyndaleSoft LLC. All rights reserved.
//

import SwiftUI
import PMDataTypes

struct FamilyJoinHeadPhaseView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var accumulator: FamilyAccumulator

    var body: some View {
        MemberEditView(
            member: accumulator.head,
            memberEditDelegate: FamilyJoinEditDelegate(),
            closingAction: { $1.store(member: $0, in: nil) },
            navigationBarTitle: accumulator.head.fullName())
    }
    
    func setPhase(to phase: FamilyJoinPhase) {
        self.accumulator.phase = phase
    }
}

/**
 Delegate implementation used only by this View.
 */
class FamilyJoinEditDelegate: MemberEditDelegate {
    @EnvironmentObject var accumulator: FamilyAccumulator
    
    func store(member: Member, in unused: Household?) {
        NSLog("FJED onDis: val is \(member.fullName())")
        self.accumulator.household.head = member
        DataFetcher.sharedInstance.add(household: accumulator.household)
        self.accumulator.phase = .household
    }
}

//struct PhaseOneView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhaseOneView()
//    }
//}

