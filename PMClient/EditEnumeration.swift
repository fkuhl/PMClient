//
//  EditEnumeration.swift
//  PMClient
//
//  Created by Frederick Kuhl on 3/21/20.
//  Copyright © 2020 TyndaleSoft LLC. All rights reserved.
//

import SwiftUI

/**
 An ultimately unsuccessful effort to make a generic enum picker.
 The problem comes with getting the data in and out.
 */

protocol StringyIterable: CaseIterable {
    var string: String { get }
}

struct EditEnumeration<E: StringyIterable>: View {
    var cases: E.Type
    var pickerTitle = "Choose:"
    var captionWidth: CGFloat = 150
    var caption: String
    @ObservedObject var choice: EnumChoiceWrapper
    
    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            Text(caption)
                .frame(width: captionWidth, alignment: .trailing)
                .font(.caption)
            Picker(selection: $choice.index, label: Text(pickerTitle)) {
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

class EnumChoiceWrapper: ObservableObject {
    var index = 0
}
