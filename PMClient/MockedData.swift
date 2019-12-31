//
//  MockedData.swift
//  PMClient
//
//  Created by Frederick Kuhl on 12/28/19.
//  Copyright © 2019 TyndaleSoft LLC. All rights reserved.
//

import Foundation
import PMDataTypes

let mv1 = MemberValue(
    familyName: "Hornswoggle",
    givenName: "Horatio",
    middleName: "Quincy",
    previousFamilyName: nil,
    nickName: "Horry",
    sex: Sex.MALE,
    household: "0",
    eMail: "horatio@nonsense.com",
    mobilePhone: "888-555-1212",
    education: "not very much",
    employer: "nobody",
    baptism: "Utopia: 1970-01-01"
)
let member1 = Member(id: "1", value: mv1)

let mv2 = MemberValue(
    familyName: "Hornswoggle",
    givenName: "Hortense",
    middleName: "",
    previousFamilyName: "Havisham",
    nickName: "",
    sex: Sex.FEMALE,
    household: "0",
    eMail: "hortense@nonsense.com",
    mobilePhone: "888-555-1213",
    education: "not very much",
    employer: "nobody",
    baptism: "Somewhere: 1970-01-01"
)

let member2 = Member(id: "2", value: mv2)

let hv0 = HouseholdValue(head: "1", spouse: "2", others: [], address: "0")

let household0 = Household(id: "0", value: hv0)

let av0 = AddressValue(
    address: "123 Plesant Avenue",
    city: "Pleasantown",
    state: "VA",
    postalCode: "54321"
)

let address0 = Address(id: "0", value: av0)


