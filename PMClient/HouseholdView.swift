//
//  HouseholdView.swift
//  PMClient
//
//  Created by Frederick Kuhl on 5/14/20.
//  Copyright © 2020 TyndaleSoft LLC. All rights reserved.
//

import SwiftUI
import PMDataTypes


protocol HouseholdMemberFactoryDelegate {
    var household: Household { get }
    func make() -> Member
}


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
    var removeButtons = false
    var spouseFactory: HouseholdMemberFactoryDelegate? = nil
    var otherFactory: HouseholdMemberFactoryDelegate? = nil
    
    var body: some View {
        VStack {
            if removeButtons {
                UnadornedHouseholdView(item: item,
                                       addressEditable: addressEditable,
                                       spouseFactory: self.spouseFactory,
                                       otherFactory: self.otherFactory)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: EmptyView(),
                                    trailing:
                    Button(action: {
                        NSLog("HV save household \(self.item.head.fullName())")
                        DataFetcher.sharedInstance.update(household: self.item)
                    }) {
                        Text("Save").font(.body)
                    }
                )
            } else {
                UnadornedHouseholdView(item: item, addressEditable: addressEditable)
            }
        }
    }
}

fileprivate struct UnadornedHouseholdView: View {
    @State var item: Household
    var addressEditable = true
    var spouseFactory: HouseholdMemberFactoryDelegate? = nil
    var otherFactory: HouseholdMemberFactoryDelegate? = nil

    var body: some View {
        Form {
            Section {
                NavigationLink(destination: MemberView(
                    member: item.head,
                    editable: true)) {
                        MemberLinkView(caption: "Head of household",
                                       name: item.head.fullName())
                }
                if item.spouse == nil {
                    NavigationLink(destination: MemberView(
                        member: makeMember(from: self.spouseFactory),
                        editable: true)) {
                            MemberLinkView(caption: "Spouse",
                                           name: "Add spouse")
                    }
                } else {
                    NavigationLink(destination: MemberView(
                        member: item.spouse!,
                        editable: true)) {
                            MemberLinkView(caption: "Spouse",
                                           name: item.spouse!.fullName())
                    }
                }
            }
            Section(header: Text("Dependents").font(.callout).italic()) {
                ForEach(item.others, id: \.id) {
                    OtherRowView(other: $0)
                }
                OtherAddView(otherFactory: self.otherFactory, household: $item)
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

fileprivate func makeMember(from factory: HouseholdMemberFactoryDelegate?) -> Member {
    if let factory = factory {
        return factory.make()
    }
    else { return Member() }
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

struct OtherAddView: View {
    var otherFactory: HouseholdMemberFactoryDelegate?
    @Binding var household: Household
    
    var body: some View {
        Button(action: {
            appendEmptyOther(to: self.$household, using: self.otherFactory)
        }) {
            Image(systemName: "plus").font(.body)
        }
    }
}

fileprivate func appendEmptyOther(to household: Binding<Household>,
                                  using factory: HouseholdMemberFactoryDelegate?) {
    household.others.wrappedValue.append(makeMember(from: factory))
}

//struct HouseholdView_Previews: PreviewProvider {
//    static var previews: some View {
//        HouseholdView()
//    }
//}
