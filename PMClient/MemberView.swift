//
//  Member"View.swift
//  PMClient
//
//  Created by Frederick Kuhl on 1/1/20.
//  Copyright © 2020 TyndaleSoft LLC. All rights reserved.
//

import SwiftUI
import PMDataTypes

struct MemberView: View {
    @State var showingEdit = false
    var member: Member
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    self.showingEdit.toggle()
                }) {
                    Text("Edit")
                    .font(.body)
                }
            }.padding()
            List {
                MemberTextAttributeView(caption: "family name:", text: member.value.familyName)
                MemberTextAttributeView(caption: "given name:", text: member.value.givenName)
                if member.value.middleName != nil {
                    MemberTextAttributeView(caption: "middle name:", text: member.value.middleName)
                }
                if member.value.previousFamilyName != nil {
                    MemberTextAttributeView(caption: "prev fam name:", text: member.value.previousFamilyName)
                }
                if member.value.nameSuffix != nil {
                    MemberTextAttributeView(caption: "suffix:", text: member.value.nameSuffix)
                }
                MemberTextAttributeView(caption: "sex:", text: member.value.sex.rawValue)
                MemberTextAttributeView(caption: "date of birth:", text: dateForDisplay(member.value.dateOfBirth))
            }
        }.sheet(isPresented: $showingEdit) {
            MemberEditView(showingEdit: self.$showingEdit, member: self.member, newFam: "Hornswoggle")
        }
    }
}

struct MemberView_Previews: PreviewProvider {
    static var previews: some View {
        MemberView(member: member1)
    }
}

func dateForDisplay(_ date: Date?) -> String {
    if let date = date {
        return dateFormatter.string(from: date)
    } else {
        return "[none]"
    }
}
