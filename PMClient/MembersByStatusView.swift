//
//  MembersByStatus.swift
//  PMClient
//
//  Created by Frederick Kuhl on 6/17/20.
//  Copyright © 2020 TyndaleSoft LLC. All rights reserved.
//

import SwiftUI
import PMDataTypes

struct MembersByStatusView: View {
    @State var includeResident = true
    @State var includeNonResident = false
    @State var desiredStatus: MemberStatus = .COMMUNING
    @State var members = [Member]()
    @State var showingResults = false
    
    var body: some View {
        VStack {
            if !showingResults {
                MembersByStatusEntryView(includeResident: $includeResident,
                               includeNonResident: $includeNonResident,
                               desiredStatus: $desiredStatus,
                               members: $members,
                               showingResults: $showingResults)
            } else {
                MembersByStatusResultsView(title: "\(members.count) Member\(members.count > 1 ? "s" : "") With Status \(desiredStatus.rawValue)",
                    members: $members,
                    showingResults: $showingResults)
            }
        }
    }
}

struct MembersByStatus_Previews: PreviewProvider {
    static var previews: some View {
        MembersByStatusView()
        .previewLayout(.fixed(width: 1068, height: 834))
    }
}
