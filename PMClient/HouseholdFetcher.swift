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
    private var publisher: AnyPublisher<[Household], Never>? = nil
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
        let url = DataFetcher.url(forCollection: .households, operation: .readAll)
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = DataFetcher.readAllBody
        publisher = URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }  //discard HTTP error return
            .decode(type: [Household].self, decoder: jsonDecoder)
            .replaceError(with: []) //dunno bout this
            .map { $0.sorted { /*print("n0: \($0.value.name()) n1: \($1.value.name())");*/ return $0.value.name() < $1.value.name() } }
            .eraseToAnyPublisher()
        sub = publisher?
            .receive(on: RunLoop.main)
            .assign(to: \.households, on: self)
        //        .sink(receiveValue: {
        //            NSLog("fetched \($0.count) households")
        //        })
    }
}
