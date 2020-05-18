//
//  EditTextView.swift
//  PMClient
//
//  Created by Frederick Kuhl on 3/21/20.
//  Copyright © 2020 TyndaleSoft LLC. All rights reserved.
//

import SwiftUI

struct EditOptionalTextView: View {
    var captionWidth: CGFloat = defaultCaptionWidth
    var caption: String
    @Binding var text: String?
    @State private var unwrappedText: String = ""
    
    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            Text(caption)
                .frame(width: captionWidth, alignment: .trailing)
                .font(.caption)
            TextField(caption, text: $unwrappedText, onEditingChanged: { changed in
                //This would be more elegant if on onDisappear, but that doesn't seem to be working.
                NSLog("EditOTV onEC '\(self.unwrappedText)'")
                self.text = self.unwrappedText
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .frame(alignment: .leading)
            .font(.body)
        }
        .onAppear() {
            NSLog("EditOTV onApp '\(self.text ?? "<nil>")'")
            self.unwrappedText = self.text ?? ""
        }
        .onDisappear() {
            NSLog("EditOTV onDis")
        }
    }
}

struct EditOptionalTextView_Previews: PreviewProvider {
    static var previews: some View {
        EditTextView(caption: "a field", text: .constant("stuff"))
    }
}
