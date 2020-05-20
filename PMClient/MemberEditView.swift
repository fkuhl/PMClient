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

struct MemberEditView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var accumulator: FamilyAccumulator
    @State var member: Member
    var memberEditDelegate: MemberEditDelegate
    var closingAction: (_ member: Member, _ delegate: MemberEditDelegate) -> Void
    var navigationBarTitle: String

    var body: some View {
        VStack {
            Form {
                Section { //Section to group in sets of <= 10
                    EditTextView(caption: "family name:", text: $member.familyName)
                    EditTextView(caption: "given name:", text: $member.givenName)
                    EditOptionalTextView(caption: "middle name:", text: $member.middleName)
                    EditOptionalTextView(caption: "prev fam name:", text: $member.previousFamilyName)
                    EditOptionalTextView(caption: "suffix:", text: $member.nameSuffix)
                    EditOptionalTextView(caption: "title:", text: $member.title)
                    EditOptionalTextView(caption: "nickname:", text: $member.nickName)
                    EditSexView(caption: "sex:", sex: $member.sex)
                }
                EditOptionalDateView(caption: "date of marriage:", date: $member.dateOfMarriage)
            }
            .navigationBarTitle(navigationBarTitle)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                Button(action: {
                    NSLog("MEV save+finish")
                    self.presentationMode.wrappedValue.dismiss()
                    self.closingAction(self.member, self.memberEditDelegate)
                }) {
                    Text("Save + Finish").font(.body)
                }
                , trailing:
                Button(action: {
                    NSLog("MEV cancel")
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel").font(.body)
                }
            )
        }
    }
}

//struct MemberEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        MemberEditView(showingEdit: .constant(false), member: member1)
//    }
//}
