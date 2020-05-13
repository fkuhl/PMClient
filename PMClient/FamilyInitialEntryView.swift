//
//  FamilyInitialEntryView.swift
//  PMClient
//
//  Created by Frederick Kuhl on 3/20/20.
//  Copyright © 2020 TyndaleSoft LLC. All rights reserved.
//

import SwiftUI
import PMDataTypes

struct FamilyInitialEntryView: View {
    @EnvironmentObject var accumulator: FamilyAccumulator
    var body: some View {
        Form {
            DateSelectionView(captionWidth: 150,
                              caption: "Date received")
            ReceptionTypeView(captionWidth: 150,
                              caption: "Reception type")
            NavigationLink(destination: MemberEditView2(member: accumulator.head, closingAction: { $1.processA(member: $0) })) {
                MemberLinkView(captionWidth: 150,
                               caption: "Head of household")
            }
            
        }
        .navigationBarTitle("Family Joins")
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

struct MemberLinkView: View {
    var captionWidth: CGFloat = 150
    var caption: String
    @EnvironmentObject var accumulator: FamilyAccumulator

    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            Text(caption)
                .frame(width: captionWidth, alignment: .trailing)
                .font(.caption)
            Spacer()
            Text(accumulator.headName()).frame(alignment: .leading).font(.body)
        }
    }
}

struct DateSelectionView: View {
    var captionWidth: CGFloat = 150
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
    }
}

struct ReceptionTypeView: View {
    var captionWidth: CGFloat = 150
    var caption: String
    @EnvironmentObject var accumulator: FamilyAccumulator

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
