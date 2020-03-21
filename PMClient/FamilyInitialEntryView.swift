//
//  FamilyInitialEntryView.swift
//  PMClient
//
//  Created by Frederick Kuhl on 3/20/20.
//  Copyright © 2020 TyndaleSoft LLC. All rights reserved.
//

import SwiftUI

struct FamilyInitialEntryView: View {
    @EnvironmentObject var accumulator: FamilyAccumulator
    var body: some View {
        Form {
            EditEnumeration(cases: ReceptionType.self, pickerTitle: "", captionWidth: 150, caption: "Reception type")
        }
    .navigationBarTitle("Manner of Reception")
    }
}

struct FamilyInitialEntryView_Previews: PreviewProvider {
    static var previews: some View {
        FamilyInitialEntryView()
    }
}
