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
            HStack { Text("family name:"); Text(member.value.familyName) }
            HStack { Text("given name:"); Text(member.value.givenName) }
//            member.value.middleName.map {
//                HStack { Text("middle name:"); Text($0) }
//            }
            
        }
    }
}

struct MemberView_Previews: PreviewProvider {
    static var previews: some View {
        MemberView(member: member1)
    }
}
