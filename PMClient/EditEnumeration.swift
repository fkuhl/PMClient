//
//  EditEnumeration.swift
//  PMClient
//
//  Created by Frederick Kuhl on 3/21/20.
//  Copyright © 2020 TyndaleSoft LLC. All rights reserved.
//

import SwiftUI

struct EditEnumeration<E: Stringable>: View {
    var cases: E.Type
    var pickerTitle = "Choose:"
    var captionWidth: CGFloat = 150
    var caption: String
    @State private var choiceIndex = 0
    
    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            Text(caption)
                .frame(width: captionWidth, alignment: .trailing)
                .font(.caption)
            Picker(selection: $choiceIndex, label: Text(pickerTitle)) {
                ForEach (0 ..< cases.allCases.count) {
                    Text("\(Array(self.cases.allCases)[$0].string)").font(.body)
                    
                }
            }
        }
    }
}


//struct EditEnumeration_Previews: PreviewProvider {
//    static var previews: some View {
//        EditEnumeration()
//    }
//}
