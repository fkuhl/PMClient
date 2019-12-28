//
//  MockedData.swift
//  PMClient
//
//  Created by Frederick Kuhl on 12/28/19.
//  Copyright © 2019 TyndaleSoft LLC. All rights reserved.
//

import Foundation

let mv1 = MemberValue(
    familyName: "Hornswoggle",
    givenName: "Horatio",
    middleName: "Quincy",
    previousFamilyName: nil,
    nameSuffix: nil,
    title: nil,
    nickName: "Horry",
    sex: Sex.MALE,
    dateOfBirth: nil,
    placeOfBirth: nil,
    status: MemberStatus.COMMUNING,
    resident: true,
    exDirectory: false,
    household: "0",
    tempAddress: nil,
    transactions: [],
    maritalStatus: MaritalStatus.MARRIED,
    spouse: "Hortense",
    dateOfMarriage: nil,
    divorce: nil,
    father: nil,
    mother: nil,
    eMail: "horatio@nonsense.com",
    workEMail: nil,
    mobilePhone: "888-555-1212",
    workPhone: nil,
    education: "not very much",
    employer: "nobody",
    baptism: "1970-01-01",
    services: [],
    dateLastChanged: nil)

let member1 = Member(id: "1", value: mv1)

let mv2 = MemberValue(
    familyName: "Hornswoggle",
    givenName: "Hortense",
    middleName: "",
    previousFamilyName: "Havisham",
    nameSuffix: nil,
    title: nil,
    nickName: "",
    sex: Sex.FEMALE,
    dateOfBirth: nil,
    placeOfBirth: nil,
    status: MemberStatus.COMMUNING,
    resident: true,
    exDirectory: false,
    household: "0",
    tempAddress: nil,
    transactions: [],
    maritalStatus: MaritalStatus.MARRIED,
    spouse: "Horatio",
    dateOfMarriage: nil,
    divorce: nil,
    father: nil,
    mother: nil,
    eMail: "hortense@nonsense.com",
    workEMail: nil,
    mobilePhone: "888-555-1213",
    workPhone: nil,
    education: "not very much",
    employer: "nobody",
    baptism: "1970-01-01",
    services: [],
    dateLastChanged: nil)

let member2 = Member(id: "2", value: mv2)

let hv0 = HouseholdValue(head: "1", spouse: "2", others: [], address: "0")

let household0 = Household(id: "0", value: hv0)

let av0 = AddressValue(
    address: "123 Plesant Avenue",
    address2: nil,
    city: "Pleasantown",
    state: "VA",
    postalCode: "54321",
    country: nil,
    eMail: nil,
    homePhone: nil)

let address0 = Address(id: "0", value: av0)


