//
//  DataFetcher.swift
//  PMClient
//
//  Created by Frederick Kuhl on 12/23/19.
//  Copyright © 2019 TyndaleSoft LLC. All rights reserved.
//

import Foundation
import PMDataTypes
import Combine

class DataFetcher: ObservableObject {
    private static let dataServerHost = "localhost"
    private static let dataServerPort = 8000
    static let readAllBody = try! jsonEncoder.encode("{}")
    
    private let fetchingQueue = DispatchQueue(label: "com.tamelea.PMClient.readAll", qos: .background)
    //these need to be ivars, so they don't go out of scope!
    private var fetchPublisher: AnyPublisher<[Household], CallError>? = nil
    private var fetchSubscriber: Cancellable? = nil
    
    private let updatingQueue = DispatchQueue(label: "com.tamelea.PMClient.update", qos: .background)
    //these need to be ivars, so they don't go out of scope!
    private var updatingPublisher: AnyPublisher<Household, CallError>? = nil
    private var updatingSubscriber: Cancellable? = nil
    
    
    // MARK: - Household data cache
    @Published public var householdIndex = [Id: Household]() {
        didSet {
            self.households = [Household](householdIndex.values)
        }
    }
    @Published public var households = [Household]()
    
    // MARK: - Member data cache
    @Published public var memberIndex = [Id: MemberIndexRecord]() {
        didSet {
            NSLog("fetched \(memberIndex.count) Members")
            let members = memberIndex.values.map { $0.member }
            self.sortedMembers = members.sorted { $0.fullName() < $1.fullName() }
            activeMembers = sortedMembers.filter { $0.status.isActive() }
        }
    }
    @Published public var sortedMembers = [Member]()
    @Published public var activeMembers = [Member]()
    
    // MARK - record fetching error
    @Published public var fetchError: CallError? = nil {
        didSet {
            showingAlert = fetchError != nil
        }
    }
    @Published var showingAlert = false
    

    // MARK: - Singleton
    public static let sharedInstance = DataFetcher()
    private init() {}
//    public static let mockedInstance = MemberFetcher(members: [member1, member2])
//    private init(members: [Member]) {
//        self.members = members
//        self.activeMembers = members
//        self.membersById = ["1": member1, "2": member2 ]
//    }

    func fetch() {
        fetchingQueue.async {
            self.loadData()
        }
    }
    
    fileprivate func loadData() {
        fetchPublisher = readAllPublisher(dataServerHost: DataFetcher.dataServerHost,
                                          dataServerPort: DataFetcher.dataServerPort)
        fetchSubscriber = fetchPublisher?
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    NSLog("call failure, err: \(error.errorString), response: \(error.reason)")
                    self.fetchError = error
                }
            }, receiveValue: { households in
                self.fetchError = nil //indicate no error
                var newIndex = [Id: Household]()
                var newMemberIndex = [Id: MemberIndexRecord]()
                households.forEach {
                    newIndex[$0.id] = $0
                    newMemberIndex[$0.head.id] = MemberIndexRecord(member: $0.head, relation: .head)
                    if let spouse = $0.spouse {
                        newMemberIndex[spouse.id] = MemberIndexRecord(member: spouse, relation: .spouse)
                    }
                    for other in $0.others {
                        newMemberIndex[other.id] = MemberIndexRecord(member: other, relation: .other)
                    }
                }
                self.householdIndex = newIndex //set it when it's complete
                self.memberIndex = newMemberIndex
            })
    }
    
    func update(to updatedMember: Member) {
        guard let householdToEdit = householdIndex[updatedMember.household] else {
            NSLog("no household to update for member \(updatedMember.fullName()); hosehold id was \(updatedMember.household)")
            return
        }
        var updated = householdToEdit
        guard let indexRecord = memberIndex[updatedMember.id] else {
            NSLog("no member index record for \(updatedMember.fullName())")
            return
        }
        switch indexRecord.relation {
        case .head:
            updated.head = updatedMember
        case .spouse:
            updated.spouse = updatedMember
        case .other:
            var newOthers = updated.others
            for i in 0 ..< newOthers.count { //yeah, I'm writing Fortran in Swift
                if newOthers[i].id == updatedMember.id {
                    newOthers[i] = updatedMember
                    break
                }
            }
            updated.others = newOthers
        }
        updatingQueue.async {
            self.updateData(to: updated)
        }
    }
    
    fileprivate func updateData(to newValue: Household) {
        let updatingPublisher = updatePublisher(to: newValue,
                                                dataServerHost: DataFetcher.dataServerHost,
                                                dataServerPort: DataFetcher.dataServerPort)
        updatingSubscriber = updatingPublisher
        .receive(on: RunLoop.main)
        .sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                NSLog("call failure, err: \(error.errorString), response: \(error.reason)")
                self.fetchError = error
            }
        }, receiveValue: { household in
            self.fetch() //reload 'em all
            self.fetchError = nil
        })
    }

//    static func url(operation: CrudOperation) -> URL {
//        return URL(string: "http://\(dataServerHost):\(dataServerPort)/\(CollectionName.households.rawValue)/\(operation.rawValue)")!
//    }
//
}

enum HouseholdRelation {
    case head
    case spouse
    case other
}

struct MemberIndexRecord {
    var member: Member
    var relation: HouseholdRelation
}
