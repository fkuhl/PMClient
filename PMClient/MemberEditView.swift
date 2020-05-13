//
//  MemberEditView.swift
//  PMClient
//
//  Created by Frederick Kuhl on 5/12/20.
//  Copyright © 2020 TyndaleSoft LLC. All rights reserved.
//

import SwiftUI
import PMDataTypes

protocol MemberEditDelegate {
    func processA(member: Member) -> Void
    func processB(member: Member) -> Void
    func processC(member: Member) -> Void
}

struct MemberEditView2: View {
    @EnvironmentObject var accumulator: FamilyAccumulator
    @State var member: Member
    var memberEditDelegate: MemberEditDelegate
    var closingAction: (_ member: Member, _ delegate: MemberEditDelegate) -> Void
    var navigationBarTitle: String
    
    var body: some View {
        VStack {
            Form {
                Section { //Section to group in sets of <= 10
                    EditTextView(caption: "Family name:", text: $member.familyName)
                    EditTextView(caption: "Given name:", text: $member.givenName)
                }
            }
        }.onDisappear() {
            self.closingAction(self.member, self.memberEditDelegate)
        }
        .navigationBarTitle(navigationBarTitle)
    }
}

//struct MemberEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        MemberEditView(showingEdit: .constant(false), member: member1)
//    }
//}
