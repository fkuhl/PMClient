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
    
    
    //these need to be ivars, so they don't go out of scope!
    private var publisher: AnyPublisher<[Member], Never>? = nil
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
        var request = URLRequest(url: DataFetcher.url(forCollection: .members, operation: .readAll))
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = DataFetcher.readAllBody
        publisher = URLSession.shared.dataTaskPublisher(for: request)
            .mapError { error -> URLError in
                NSLog("error fetching members: \(error.localizedDescription)")
                return error
            }
            .map { $0.data }  //discard HTTP error return
            .decode(type: [Member].self, decoder: jsonDecoder)
            .mapError { error -> Error in
                NSLog("decoding error fetching Members: \(error.localizedDescription)")
                return error
            }
            .replaceError(with: []) //return empty array on decode error
            .map { $0.sorted { $0.value.fullName() < $1.value.fullName() } }
            .eraseToAnyPublisher()
        sub = publisher?
            .receive(on: RunLoop.main)
            .assign(to: \.members, on: self)
    }
}
