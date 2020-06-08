//
//  HouseholdView.swift
//  PMClient
//
//  Created by Frederick Kuhl on 5/14/20.
//  Copyright © 2020 TyndaleSoft LLC. All rights reserved.
//

import SwiftUI
import PMDataTypes

class HouseholdAddressEditDelegate: AddressEditDelegate {
    var householdId: Id
    
    init(householdId: Id) {
        self.householdId = householdId
    }

    func store(address: Address) {
        NSLog("HAED addr: \(address.address ?? "[none]")")
        DataFetcher.sharedInstance.update(householdId: self.householdId, to: address)
    }
}

struct HouseholdView: View {
    var item: Household
    var addressEditable = true
    
    var body: some View {
        Form {
            Section {
                NavigationLink(destination: MemberView(
                    member: item.head,
                    editable: true)) {
                        MemberLinkView(captionWidth: defaultCaptionWidth,
                                       caption: "Head of household",
                                       name: item.head.fullName())
                }
                if item.spouse == nil {
                    // TODO edit + add spouse
                } else {
                    NavigationLink(destination: MemberView(
                        member: item.spouse!,
                        editable: true)) {
                            MemberLinkView(captionWidth: defaultCaptionWidth,
                                           caption: "Spouse",
                                           name: item.spouse!.fullName())
                    }
                }
            }
            if !item.others.isEmpty {
                Section(header: Text("Dependents").font(.callout).italic()) {
                    ForEach(item.others, id: \.id) {
                        OtherRowView(other: $0)
                    }
                }
            }
            Section(header: Text("Address").font(.callout).italic()) {
                if nugatory(item.address) {
                    NavigationLink(destination: AddressEditView(addressEditDelegate: HouseholdAddressEditDelegate(householdId: item.id), address: Address())) {
                        Text("Add address").font(.body)
                    }
                } else {
                    NavigationLink(destination: AddressEditView(addressEditDelegate: HouseholdAddressEditDelegate(householdId: item.id), address: item.address!)) {
                        Text("Edit: \(item.address!.addressForDisplay())").font(.body)
                    }
                }
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
            editable: true)) {
                MemberLinkView(captionWidth: defaultCaptionWidth,
                               caption: "",
                               name: other.fullName())
        }
    }
}

struct MemberLinkView: View {
    var captionWidth: CGFloat = defaultCaptionWidth
    var caption: String
    var name: String

    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            Text(caption)
                .frame(width: captionWidth, alignment: .trailing)
                .font(.caption)
            Spacer()
            Text(name).frame(alignment: .leading).font(.body)
        }
    }
}

//struct HouseholdView_Previews: PreviewProvider {
//    static var previews: some View {
//        HouseholdView()
//    }
//}
