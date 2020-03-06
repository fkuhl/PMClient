//
//  MemberEditView.swift
//  PMClient
//
//  Created by Frederick Kuhl on 2/4/20.
//  Copyright © 2020 TyndaleSoft LLC. All rights reserved.
//

import SwiftUI
import PMDataTypes

struct MemberEditView: View {
    @Binding var showingEdit: Bool
    @State var member: Member
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    self.showingEdit.toggle()
                }) {
                    Text("Save and close")
                        .font(.body)
                }
            }.padding()
            Form {
                Section { //Section to group in sets of <= 10
                    MemberEditTextView(caption: "Family name:", text: $member.familyName)
                    MemberEditTextView(caption: "Given name:", text: $member.givenName)
                }
            }
        }.onDisappear() {
            NSLog("onDis: val is \(self.member.givenName)")
            DataFetcher.sharedInstance.update(to: self.member)
        }
    }
}

//struct MemberEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        MemberEditView(showingEdit: .constant(false), member: member1)
//    }
//}
