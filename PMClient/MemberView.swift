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
                MemberTextAttributeView(caption: "family name:", text: member.familyName)
                MemberTextAttributeView(caption: "given name:", text: member.givenName)
                if member.middleName != nil {
                    MemberTextAttributeView(caption: "middle name:", text: member.middleName)
                }
                if member.previousFamilyName != nil {
                    MemberTextAttributeView(caption: "prev fam name:", text: member.previousFamilyName)
                }
                if member.nameSuffix != nil {
                    MemberTextAttributeView(caption: "suffix:", text: member.nameSuffix)
                }
                MemberTextAttributeView(caption: "sex:", text: member.sex.rawValue)
                MemberTextAttributeView(caption: "date of birth:", text: dateForDisplay(member.dateOfBirth))
            }
        }.sheet(isPresented: $showingEdit) {
            MemberEditView(showingEdit: self.$showingEdit, member: self.member)
        }
    }
}

//struct MemberView_Previews: PreviewProvider {
//    static var previews: some View {
//        MemberView(member: member1)
//    }
//}

func dateForDisplay(_ date: Date?) -> String {
    if let date = date {
        return dateFormatter.string(from: date)
    } else {
        return "[none]"
    }
}
