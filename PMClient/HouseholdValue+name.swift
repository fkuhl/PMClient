//
//  HouseholdValue+name.swift
//  PMClient
//
//  Created by Frederick Kuhl on 12/30/19.
//  Copyright © 2019 TyndaleSoft LLC. All rights reserved.
//

import Foundation
import PMDataTypes

extension HouseholdValue {
    func name() -> String {
        guard let member  = MemberFetcher.sharedInstance.membersById[head] else {
            return "<no member among \(MemberFetcher.sharedInstance.membersById.count)>"
        }
        return member.value.fullName()
    }
}
