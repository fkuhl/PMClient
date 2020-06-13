//
//  MemberInHouseholdView.swift
//  PMClient
//
//  Created by Frederick Kuhl on 6/12/20.
//  Copyright © 2020 TyndaleSoft LLC. All rights reserved.
//

/**
 Like MemberView,  but in context of editing or adding Household.
 */

import SwiftUI
import PMDataTypes

struct MemberInHouseholdView: View {
    var member: Member
    @Binding var household: Household
    var relation: HouseholdRelation
    var editable = true
    
    var body: some View {
        CoreMemberView(member: self.member,
                       memberEditDelegate: MemberInHouseholdViewEditDelegate(
                        household: self.household, relation: self.relation),
                       editable: self.editable,
                       closingAction: { $1.store(member: $0, in: self.household) })
    }
}

//{ $1.store(member: $0, in: nil) }
fileprivate class MemberInHouseholdViewEditDelegate: MemberEditDelegate {
    var relation: HouseholdRelation
    
    init(household: Household, relation: HouseholdRelation) {
        self.relation = relation
    }
    
    func store(member: Member, in household: Household?) {
        guard let household = household  else {
            NSLog("MIHVED with nil household")
            return
        }
        NSLog("MIHVED store: val is \(member.fullName())")
        var localH = household
        switch self.relation {
        case .head:
            localH.head = member
        case .spouse:
            localH.spouse = member
        case .other:
            if let otherIndex = localH.others.firstIndex(where: {$0.id == member.id}) {
                localH.others[otherIndex] = member
            } else {
                NSLog("MIHVED no entry for other \(member.id)")
            }
        }
        NSLog("MIHVED storing with \(localH.others.count) others")
        DataFetcher.sharedInstance.update(household: localH)
    }
}

//struct MemberInHouseholdView_Previews: PreviewProvider {
//    static var previews: some View {
//        MemberInHouseholdView()
//    }
//}
