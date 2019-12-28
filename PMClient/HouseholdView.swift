//
//  HouseholdView.swift
//  PMClient
//
//  Created by Frederick Kuhl on 12/23/19.
//  Copyright © 2019 TyndaleSoft LLC. All rights reserved.
//

import SwiftUI

struct HouseholdView: View {
    @EnvironmentObject var householdFetcher: HouseholdFetcher
    var body: some View {
        VStack {
            List {
                ForEach(householdFetcher.households, id: \.id) {
                    Text($0.value.name())
                }
            }
        }
    }
}

struct HouseholdView_Previews: PreviewProvider {
    static var previews: some View {
        HouseholdView()
    }
}
