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
    var member: Member
    
    var body: some View {
        List {
            MemberTextAttributeView(caption: "family name:", text: member.value.familyName)
            MemberTextAttributeView(caption: "given name:", text: member.value.givenName)
            MemberTextAttributeView(caption: "middle name:", text: member.value.middleName)
            MemberTextAttributeView(caption: "prev fam name:", text: member.value.previousFamilyName)
            MemberTextAttributeView(caption: "suffix:", text: member.value.nameSuffix)
            MemberTextAttributeView(caption: "sex:", text: member.value.sex.rawValue)
            MemberTextAttributeView(caption: "date of birth:", text: dateForDisplay(member.value.dateOfBirth))
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
