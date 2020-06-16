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
            memberEditDelegate: FamilyJoinEditDelegate(accumulator: accumulator),
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
    var accumulator: FamilyAccumulator
    
    init(accumulator: FamilyAccumulator) {
        self.accumulator = accumulator
    }
    
    func store(member: Member, in unused: Binding<Household>?) {
        NSLog("FJED onDis: val is \(member.fullName())")
        var newHousehold = Household()
        newHousehold.head = member
        DataFetcher.sharedInstance.add(household: newHousehold)
        self.accumulator.phase = .household
    }
}

//struct PhaseOneView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhaseOneView()
//    }
//}

