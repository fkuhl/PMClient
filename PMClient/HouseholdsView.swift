//
//  HouseholdView.swift
//  PMClient
//
//  Created by Frederick Kuhl on 12/23/19.
//  Copyright © 2019 TyndaleSoft LLC. All rights reserved.
//

import SwiftUI

struct HouseholdsView: View {
    @ObservedObject var dataFetcher = DataFetcher.sharedInstance
    var body: some View {
        VStack {
            List {
                ForEach(dataFetcher.households, id: \.id) {
                    Text($0.head.fullName())
                }
            }
        }
    }
}

//struct HouseholdView_Previews: PreviewProvider {
//    static var previews: some View {
//        HouseholdsView().environmentObject(HouseholdFetcher.mockedInstance)
//    }
//}
