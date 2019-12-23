//
//  DataFetcher.swift
//  PMClient
//
//  Created by Frederick Kuhl on 12/20/19.
//  Copyright © 2019 TyndaleSoft LLC. All rights reserved.
//

import Foundation
import Combine

class HouseholdFetcher: ObservableObject {
    private let dataServerHost = "localhost"
    private let dataServerPort = 8123
    private let readAllBody = try! jsonEncoder.encode("{}")
    private let fetchingQueue = DispatchQueue(label: "com.tamelea.PMClient.household", qos: .background)
    
    
    @Published public var households = [Household]()
    //these need to be ivars, so they don't go out of scope!
    private var publisher: AnyPublisher<[Household], Never>? = nil
    private var sub: Cancellable? = nil

    // MARK: - Singleton
    
    public static let sharedInstance = HouseholdFetcher()
    private init() {}
    
    func fetch() {
        fetchingQueue.async {
            self.loadData()
        }
    }
    
    func loadData() {
        let url = URL(string: "http://\(dataServerHost):\(dataServerPort)/\(CollectionName.households.rawValue)/\(CrudOperation.readAll.rawValue)")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = readAllBody
        publisher = URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }  //discard HTTP error return
            .decode(type: [Household].self, decoder: jsonDecoder)
            .replaceError(with: []) //dunno bout this
            //.map { $0.sorted { $0.value.fullName() < $1.value.fullName() } }
            .eraseToAnyPublisher()
        sub = publisher?
            .receive(on: RunLoop.main)
        .sink(receiveValue: {
            NSLog("fetched \($0.count) households")
        })
        //.assign(to: \.households, on: self)
    }
}
