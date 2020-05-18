//
//  EditSexView.swift
//  PMClient
//  The name of this file, and its struct, should not be construed as an assertion
//  that a person's sex is "editable."
//  Created by Frederick Kuhl on 5/18/20.
//  Copyright © 2020 TyndaleSoft LLC. All rights reserved.
//

import SwiftUI
import PMDataTypes

struct EditSexView: View {
    var captionWidth: CGFloat = defaultCaptionWidth
    var caption: String
    @Binding var sex: Sex
    
    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            Text(caption)
                .frame(width: captionWidth, alignment: .trailing)
                .font(.caption)
            Picker(selection: $sex, label: Text("")) {
                ForEach (Sex.allCases, id: \.self) {
                    //Don't forget the tag!
                    Text($0.rawValue).font(.body).tag($0)
                }
            }
        }
//        .onAppear() {
//            NSLog("EditSV onApp \(self.sex.rawValue)")
//        }
//        .onDisappear() {
//            NSLog("EditSV onDis \(self.sex.rawValue)")
//        }
    }
}

//struct EditSexView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditSexView()
//    }
//}
