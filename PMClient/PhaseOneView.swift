//
//  PhaseOneView.swift
//  PMClient
//
//  Created by Frederick Kuhl on 6/5/20.
//  Copyright © 2020 TyndaleSoft LLC. All rights reserved.
//

import SwiftUI
import PMDataTypes

struct PhaseOneView: View {
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
        }
        .navigationBarTitle("Family Joins")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            Button(action: {
                NSLog("Ph1 cancel")
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

//struct PhaseOneView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhaseOneView()
//    }
//}
