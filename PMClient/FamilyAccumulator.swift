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
    
    @Published var seed = UUID().uuidString
    @Published var dateReceived = Date()
    //The picker needs an Int index, and it needs to be stored here.
    @Published var receptionTypeIndex = 2
    @Published var churchFrom = ""
    @Published var head: Member = Member()
    @Published var spouse: Member = Member()

    func headName() -> String {
        self.head.fullName()
    }
    
    init() {
        NSLog("new accum \(seed)")
    }
    
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

enum ReceptionType: String, CaseIterable {
    static var stringArray: [String] {
        get {
            ReceptionType.allCases.map { $0.rawValue }
        }
    }
    
    case PROFESSION
    case AFFIRMATION
    case TRANSFER
}
