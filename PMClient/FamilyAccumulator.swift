//
//  FamilyAccumulator.swift
//  PMClient
//
//  Created by Frederick Kuhl on 3/21/20.
//  Copyright © 2020 TyndaleSoft LLC. All rights reserved.
//

import Foundation
/**
 Accumulate the data needed to add a family to the DB as user steps through the various screens.
 */

class FamilyAccumulator: ObservableObject {
    var seed = UUID()
    var dateReceived = Date()
    var receptionType: ReceptionType = .TRANSFER
    var churchFrom = ""
    

    // MARK: - Singleton
    public static let sharedInstance = FamilyAccumulator()
    private init() {}
    
    /**
     Prepare accumulator to accumulate fresh data
     */
    func clear() -> FamilyAccumulator {
        seed = UUID()
        return self
    }
}

protocol Stringable: CaseIterable {
    var string: String { get }
}

enum ReceptionType: String, Stringable {
        var string: String {
            return rawValue
        }
        
    case PROFESSION
    case AFFIRMATION
    case TRANSFER
}
