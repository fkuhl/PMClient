//
//  MemberEditTextView.swift
//  PMClient
//
//  Created by Frederick Kuhl on 2/7/20.
//  Copyright © 2020 TyndaleSoft LLC. All rights reserved.
//

import SwiftUI

struct MemberEditTextView: View {
    var caption: String
    @Binding var text: String
    
    var body: some View {
        HStack {
            Text(caption)
                .frame(width: 150, alignment: .trailing) //a magic number for you
                .font(.caption)
            TextField(caption, text: $text)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .frame(alignment: .leading)
            .font(.body)
        }
    }
}

struct MemberEditTextView_Previews: PreviewProvider {
    static var previews: some View {
        MemberEditTextView(caption: "a field", text: .constant("stuff"))
    }
}
