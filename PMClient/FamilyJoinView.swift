//
//  FamilyInitialEntryView.swift
//  PMClient
//
//  Created by Frederick Kuhl on 3/20/20.
//  Copyright © 2020 TyndaleSoft LLC. All rights reserved.
//

import SwiftUI
import PMDataTypes

struct FamilyJoinView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var accumulator: FamilyAccumulator
    var body: some View {
        Form {
            Section {
                DateSelectionView(caption: "Date received")
                ReceptionTypeView(caption: "Reception type")
                EditTextView(caption: "church from", text: $accumulator.churchFrom)
                EditTextView(caption: "authority", text: $accumulator.authority)
                EditTextView(caption: "comment", text: $accumulator.comment)
            }
            Section(header: Text("Head of Household").font(.callout).italic()) {
                NavigationLink(destination: MemberEditView(
                    member: accumulator.head,
                    memberEditDelegate: accumulator,
                    closingAction: { $1.processA(member: $0) },
                    navigationBarTitle: "Head of Household")) {
                        MemberLinkView(captionWidth: defaultCaptionWidth,
                                       caption: "Head of household",
                                       name: accumulator.head.fullName())
                }
            }
            Section(header: Text("Spouse").font(.callout).italic()) {
                NavigationLink(destination: MemberEditView(
                    member: accumulator.spouse,
                    memberEditDelegate: accumulator,
                    closingAction: { $1.processB(member: $0) },
                    navigationBarTitle: "Spouse")) {
                        MemberLinkView(captionWidth: defaultCaptionWidth,
                                       caption: "Spouse",
                                       name: accumulator.spouse.fullName())
                }
            }
            ForEach(accumulator.others, id: \.id) {
                OtherRowView(other: $0)
            }
            //Need a "+" button
            // TODO need to rearrange so only show addr after household made in DB 
//            Section(header: Text("Address").font(.callout).italic()) {
//                NavigationLink(destination: AddressView(address: $accumulator.address, addressEditDelegate: accumulator)) {
//                    Text("Address").font(.body)
//                }
//            }
        }
        .navigationBarTitle("Family Joins")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            Button(action: {
                NSLog("MEV cancel")
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Cancel").font(.body)
            }
            , trailing:
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
                // TODO save this puppy
            }) {
                Text("Save + Finish").font(.body)
            }
        )
    }
}

//struct FamilyInitialEntryView_Previews: PreviewProvider {
//    static var previews: some View {
//        FamilyInitialEntryView()
//    }
//}

fileprivate struct OtherRowView: View {
    var other: Member
    @EnvironmentObject var accumulator: FamilyAccumulator

    var body: some View {
        NavigationLink(destination: MemberEditView(
                member: other,
                memberEditDelegate: accumulator,
                closingAction: { $1.processC(member: $0) },
                navigationBarTitle: "Other Member")) {
            MemberLinkView(captionWidth: defaultCaptionWidth,
                           caption: "",
                           name: accumulator.spouse.fullName())
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

struct DateSelectionView: View {
    var captionWidth: CGFloat = defaultCaptionWidth
    var caption: String
    @EnvironmentObject var accumulator: FamilyAccumulator

    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            Text(caption)
                .frame(width: captionWidth, alignment: .trailing)
                .font(.caption)
            DatePicker("",
                       selection: $accumulator.dateReceived,
                       in: ...Date(),
                       displayedComponents: .date).font(.body)
        }
        .onAppear() {
            NSLog("DSV onApp")
        }
        .onDisappear() {
            NSLog("DSV onDis")
        }
    }
}

struct ReceptionTypeView: View {
    var captionWidth: CGFloat = defaultCaptionWidth
    var caption: String
    @EnvironmentObject var accumulator: FamilyAccumulator

    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            Text(caption)
                .frame(width: captionWidth, alignment: .trailing)
                .font(.caption)
            Picker(selection: $accumulator.receptionType, label: Text("")) {
                ForEach (ReceptionType.allCases, id: \.self) {
                    //Don't forget the tag!
                    Text($0.rawValue).font(.body).tag($0)
                }
            }
        }
    }
}
