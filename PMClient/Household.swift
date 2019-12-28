//
//  Household.swift
//  
//
//  Created by Frederick Kuhl on 11/13/19.
//

import Foundation

struct Household: DataType {
    var id: Id
    var value: HouseholdValue
}

struct HouseholdValue: ValueType {
    var head: Id? //this would have to be an error
    var spouse: Id?
    var others: [Id]
    var address: Id

    func name() -> String {
        guard let head = head else {
            return "<no head>"
        }
        guard let member  = MemberFetcher.sharedInstance.membersById[head] else {
            return "<no member among \(MemberFetcher.sharedInstance.membersById.count)>"
        }
        return member.value.fullName()
    }
}

