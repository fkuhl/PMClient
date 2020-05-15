//
//  HouseholdView.swift
//  PMClient
//
//  Created by Frederick Kuhl on 5/14/20.
//  Copyright © 2020 TyndaleSoft LLC. All rights reserved.
//

import SwiftUI
import PMDataTypes

struct HouseholdView: View {
    var item: Household
    
    var body: some View {
        Form {
            NavigationLink(destination: MemberView(
                member: item.head,
                editable: false)) {
                    MemberLinkView(captionWidth: 150,
                                   caption: "Head of household",
                                   name: item.head.fullName())
            }
            if item.spouse != nil {
                NavigationLink(destination: MemberView(
                    member: item.spouse!,
                    editable: false)) {
                        MemberLinkView(captionWidth: 150,
                                       caption: "Spouse",
                                       name: item.spouse!.fullName())
                }
            }
            ForEach(item.others, id: \.id) {
                OtherRowView(other: $0)
            }
        }
        .navigationBarTitle(item.head.fullName())
    }
}

fileprivate struct OtherRowView: View {
    var other: Member
    
    var body: some View {
        NavigationLink(destination: MemberView(
            member: other,
            editable: false)) {
                MemberLinkView(captionWidth: 150,
                               caption: "",
                               name: other.fullName())
        }
    }
}

//struct HouseholdView_Previews: PreviewProvider {
//    static var previews: some View {
//        HouseholdView()
//    }
//}
