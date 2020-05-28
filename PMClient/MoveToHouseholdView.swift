//
//  MoveToHouseholdView.swift
//  PMClient
//
//  Created by Frederick Kuhl on 5/22/20.
//  Copyright © 2020 TyndaleSoft LLC. All rights reserved.
//

import SwiftUI

struct MoveToHouseholdView: View {
    @EnvironmentObject var accumulator: MoveToHouseholdAccumulator
    
    var body: some View {
        Form {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .navigationBarTitle("Member Moves To Different Household")
    }
}

//struct MoveToHouseholdView_Previews: PreviewProvider {
//    static var previews: some View {
//        MoveToHouseholdView()
//    }
//}
