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

class FamilyAccumulator: ObservableObject, MemberEditDelegate {
    
    
    @Published var dateReceived = Date()
    @Published var receptionType: ReceptionType = .TRANSFER
    @Published var churchFrom = ""
    @Published var authority = ""
    @Published var comment = ""
    @Published var head: Member = Member()
    @Published var spouse: Member = Member()
    @Published var others: [Member] = [Member]()
    @Published var address: Address = Address()
    
    // MARK - MemberEditDelegate
    func processA(member: Member) {
        self.head = member
    }
    
    func processB(member: Member) {
        self.spouse = member
    }
    
    func processC(member: Member) {
        // TODO for others
    }
}

class FamilyAddressEditDelegate: AddressEditDelegate {
    var householdId: Id

    init(householdId: Id) {
        self.householdId = householdId
    }
    
    func store(address: Address) {
        // TODO
    }
}

enum ReceptionType: String, CaseIterable {
    case PROFESSION
    case AFFIRMATION
    case TRANSFER
}
