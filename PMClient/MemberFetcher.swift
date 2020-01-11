//
//  MemberFetcher.swift
//  PMClient
//
//  Created by Frederick Kuhl on 12/20/19.
//  Copyright © 2019 TyndaleSoft LLC. All rights reserved.
//

import Foundation
import Combine
import PMDataTypes

class MemberFetcher: ObservableObject {
    private let fetchingQueue = DispatchQueue(label: "com.tamelea.PMClient.member", qos: .background)
    
    @Published public var members = [Member]() {
        didSet {
            NSLog("fetched \(members.count) Members")
            activeMembers = members.filter { $0.value.status.isActive() }
            membersById = [Id : Member]()
            for member in members { membersById[member.id] = member }
            HouseholdFetcher.sharedInstance.fetch()
}
    }
    public var activeMembers = [Member]()
    public var membersById = [Id : Member]()
    public var fetchError: CallError? = nil {
        didSet {
            showingAlert = fetchError != nil
        }
    }
    @Published var showingAlert = false
    
    //these need to be ivars, so they don't go out of scope!
    private var publisher: AnyPublisher<[Member], CallError>? = nil
    private var sub: Cancellable? = nil

    // MARK: - Singleton
    public static let sharedInstance = MemberFetcher()
    private init() {}
    public static let mockedInstance = MemberFetcher(members: [member1, member2])
    private init(members: [Member]) {
        self.members = members
        self.activeMembers = members
        self.membersById = ["1": member1, "2": member2 ]
    }

    func fetch() {
        fetchingQueue.async {
            self.loadData()
        }
    }
    
    func loadData() {
        publisher = readAllPublisher(collection: .members)
        sub = publisher?
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    NSLog("call failure, err: \(error.errorString), response: \(error.reason)")
                    self.fetchError = error
                }
            }, receiveValue: { members in
                let sorted = members.sorted { $0.value.fullName() < $1.value.fullName() }
                self.members = sorted
                self.fetchError = nil
            })
    }
}
