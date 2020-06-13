//
//  FamilyAccumulator.swift
//  PMClient
//
//  Created by Frederick Kuhl on 3/21/20.
//  Copyright © 2020 TyndaleSoft LLC. All rights reserved.
//

import Foundation
import PMDataTypes
/**
 Accumulate the data needed to add a family to the DB as user steps through the various screens.
 */

class FamilyAccumulator: ObservableObject {
    
    @Published var phase: FamilyJoinPhase = .transaction
    @Published var dateReceived = Date()
    @Published var receptionType: ReceptionType = .TRANSFER
    @Published var churchFrom = ""
    @Published var authority = ""
    @Published var comment = ""
    @Published var head: Member = Member()
    @Published var receptionTransaction = Transaction()
    @Published var household = Household()
    
}

enum FamilyJoinPhase {
    case transaction
    case head
    case household
}

class FamilyAddressEditDelegate: AddressEditDelegate {
    
    func store(address: Address, in household: Household) {
        // TODO
    }
}

enum ReceptionType: String, CaseIterable {
    case PROFESSION
    case AFFIRMATION
    case TRANSFER
}
