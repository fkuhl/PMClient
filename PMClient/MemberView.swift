//
//  MemberView.swift
//  PMClient
//
//  Created by Frederick Kuhl on 1/1/20.
//  Copyright © 2020 TyndaleSoft LLC. All rights reserved.
//

import SwiftUI
import PMDataTypes

struct MemberView: View {
    var member: Member
    let memberEditDelegate = MemberViewEditDelegate()
    var editable = true
    
    var body: some View {
        VStack {
            if editable {
                HStack {
                    Spacer()
                    NavigationLink(
                        destination: MemberEditView(
                            member: member,
                            memberEditDelegate: memberEditDelegate,
                            closingAction: { $1.processA(member: $0) },
                            navigationBarTitle: member.fullName()))  {
                                Text("Edit").font(.body)
                    }
                }.padding()
            }
            List {
                Section {
                    TextAttributeView(caption: "family name:", text: member.familyName)
                    TextAttributeView(caption: "given name:", text: member.givenName)
                    if member.middleName != nil {
                        TextAttributeView(caption: "middle name:", text: member.middleName)
                    }
                    if member.previousFamilyName != nil {
                        TextAttributeView(caption: "prev fam name:", text: member.previousFamilyName)
                    }
                    if member.nameSuffix != nil {
                        TextAttributeView(caption: "suffix:", text: member.nameSuffix)
                    }
                    TextAttributeView(caption: "sex:", text: member.sex.rawValue)
                    TextAttributeView(caption: "date of birth:", text: dateForDisplay(member.dateOfBirth))
                    TextAttributeView(caption: "status:", text: member.status.rawValue)
                    TextAttributeView(caption: "resident:", text: member.resident ? "yes" : "no")
                    TextAttributeView(caption: "household:", text: householdName(for: member))
                }
                Section {
                    Text("Transactions").font(.callout).italic()
                    TransactionsView(member: member)
                }
                if member.services.count > 0 {
                 Section {
                        Text("Services").font(.callout).italic()
                        ServicesView(member: member)
                    }
                }
            }
        }.navigationBarTitle("\(member.fullName())")
    }
}

fileprivate func householdName(for member: Member) -> String {
    let household = DataFetcher.sharedInstance.householdIndex[member.household]
    return household == nil ? "[none]" : household!.head.fullName()
}

/**
 Delegate implementation used only by MemberView.
 */
class MemberViewEditDelegate: MemberEditDelegate {
    func processA(member: Member) {
        NSLog("onDis: val is \(member.givenName)")
        DataFetcher.sharedInstance.update(to: member)
    }
    
    func processB(member: Member) {
        //not used
    }
    
    func processC(member: Member) {
        // not used
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
