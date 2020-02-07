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
    var member: Member
    @State var newFam: String
//    @State var newValue: MemberValue
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    self.showingEdit.toggle()
                }) {
                    Image(systemName: "tray.and.arrow.down")
                }
            }.padding()
            Form {
                Section {
                    Text("Family name:")
                    TextField("Family name", text: $newFam)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
        }
    }
}

struct MemberEditView_Previews: PreviewProvider {
    static var previews: some View {
        MemberEditView(showingEdit: .constant(false), member: member1, newFam: "stuff" /*, newValue: member1.value*/)
    }
}
