//
//  DataFetcher.swift
//  PMClient
//
//  Created by Frederick Kuhl on 12/20/19.
//  Copyright © 2019 TyndaleSoft LLC. All rights reserved.
//

import Foundation
import Combine
import PMDataTypes

class HouseholdFetcher: ObservableObject {
    private let fetchingQueue = DispatchQueue(label: "com.tamelea.PMClient.household", qos: .background)
    
    
    @Published public var households = [Household]() {
        didSet {
            NSLog("fetched \(households.count) Households")
            householdsById = [Id : Household]()
            for household in households { householdsById[household.id] = household }
            AddressFetcher.sharedInstance.fetch()
        }
    }
    public var householdsById = [Id : Household]()
    
    //these need to be ivars, so they don't go out of scope!
    private var publisher: AnyPublisher<[Household], CallError>? = nil
    private var sub: Cancellable? = nil

    // MARK: - Singleton
    
    public static let sharedInstance = HouseholdFetcher()
    private init() {}
    public static let mockedInstance = HouseholdFetcher(households: [household0])
    private init(households: [Household]) {
        self.households = households
    }
    
    func fetch() {
        fetchingQueue.async {
            self.loadData()
        }
    }
    
    func loadData() {
        publisher = readAllPublisher(collection: .households)
        sub = publisher?
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    NSLog("call failure, err: \(error.errorString), response: \(error.reason)")
                    //TODO: error handling for UI
                }
            }, receiveValue: { households in
                self.households = households
            })
    }
}
