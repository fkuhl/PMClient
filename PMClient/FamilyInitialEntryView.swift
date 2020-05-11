//
//  FamilyInitialEntryView.swift
//  PMClient
//
//  Created by Frederick Kuhl on 3/20/20.
//  Copyright © 2020 TyndaleSoft LLC. All rights reserved.
//

import SwiftUI

struct FamilyInitialEntryView: View {
    @ObservedObject var accumulator = FamilyAccumulator()
    var body: some View {
        Form {
            ReceptionTypeView(captionWidth: 150,
                              caption: "Reception type",
                              accumulator: accumulator)
            
        }
        .navigationBarTitle("Manner of Reception")
        .onAppear() {
            NSLog("onAppear \(self.accumulator.seed)")
        }
    }
}

//struct FamilyInitialEntryView_Previews: PreviewProvider {
//    static var previews: some View {
//        FamilyInitialEntryView()
//    }
//}

struct ReceptionTypeView: View {
    var captionWidth: CGFloat = 150
    var caption: String
    @ObservedObject var accumulator: FamilyAccumulator

    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            Text(caption)
                .frame(width: captionWidth, alignment: .trailing)
                .font(.caption)
            Picker(selection: $accumulator.receptionTypeIndex, label: Text("")) {
                //The ForEach can be written using just ReceptionType.stringArray, but then the Picker doesn't work.
                ForEach (0 ..< ReceptionType.stringArray.count, id: \.self) {
                    //Don't forget the tag!
                    Text(ReceptionType.stringArray[$0]).font(.body).tag($0)
                }
            }
        }
    }
}
