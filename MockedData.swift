//
//  MockedData.swift
//  PMClient
//
//  Created by Frederick Kuhl on 12/28/19.
//  Copyright © 2019 TyndaleSoft LLC. All rights reserved.
//

import Foundation
import PMDataTypes

fileprivate func makeMv1() -> Member {
    var mv1 = Member()
    mv1.id = "123"
    mv1.familyName = "Hornswoggle"
    mv1.givenName = "Horatio"
    mv1.middleName = "Quincy"
    mv1.previousFamilyName = nil
    mv1.nickname = "Horry"
    mv1.sex = Sex.MALE
    mv1.household = "0"
    mv1.eMail = "horatio@nonsense.com"
    mv1.mobilePhone = "888-555-1212"
    mv1.baptism = "Utopia: 1970-01-01"
    return mv1
}
let mockMember1 = makeMv1()

let mockMember2 = Member(
    familyName: "Hornswoggle",
    givenName: "Hortense",
    middleName: "",
    previousFamilyName: "Havisham",
    nickname: "",
    sex: Sex.FEMALE,
    household: "0",
    eMail: "hortense@nonsense.com",
    mobilePhone: "888-555-1213",
    baptism: "Somewhere: 1970-01-01")

let mockAddress = Address(
    address: "123 Plesant Avenue",
    city: "Pleasantown",
    state: "VA",
    postalCode: "54321"
)

let mockHousehold = Household(id: "xxx",
                              head: mockMember1,
                              spouse: mockMember2,
                              address: mockAddress)

