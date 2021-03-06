//
//  MemberQueryEntryView.swift
//  PMClient
//
//  Created by Frederick Kuhl on 6/18/20.
//  Copyright © 2020 TyndaleSoft LLC. All rights reserved.
//

import SwiftUI
import PMDataTypes

struct MembersByStatusEntryView: View {
    @Binding var includeResident: Bool
    @Binding var includeNonResident: Bool
    @Binding var desiredStatus: MemberStatus
    @Binding var members: [Member]
    @Binding var showingResults: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 20.0) {
            Text("Query Members by Status").font(.title).padding(30)
            HStack(alignment: .center, spacing: 20) {
                Spacer()
                CompactToggleView(isOn: $includeResident, label: "Include residents")
                Spacer()
                CompactToggleView(isOn: $includeNonResident, label: "Include non-residents")
                Spacer()
            }
            HStack(spacing: 20) {
                Spacer()
                Text("With status:").font(.body)
                Picker(selection: $desiredStatus, label: Text("")) {
                    ForEach (MemberStatus.allCases, id: \.self) {
                        //Don't forget the tag!
                        Text($0.rawValue).font(.body).tag($0)
                    }
                }.frame(maxWidth: 300)/*.background(Color.yellow)*/
                Spacer()
            }
            HStack {
                Button(action: {
                    NSLog("run query")
                    self.members = DataFetcher.sharedInstance.sortedMembers.filter {
                        $0.status == self.desiredStatus &&
                            ((self.includeResident && $0.resident)
                                || (self.includeNonResident && !$0.resident))
                    }
                    self.showingResults = true
                }) {
                    Text("Query").font(.title)
                }.padding(20)
            }
            Spacer()
        }.padding(20)
    }
}

struct MembersByStatusEntryView_Previews: PreviewProvider {
    static var previews: some View {
        MembersByStatusEntryView(includeResident: .constant(true),
                             includeNonResident: .constant(false),
                             desiredStatus: .constant(.COMMUNING),
                             members: .constant([Member]()),
                             showingResults: .constant(false))
        .previewLayout(.sizeThatFits)
        .padding()
        .background(Color(.systemBackground))
        .environment(\.colorScheme, .dark)
        .previewDisplayName("Preview")
    }
}
