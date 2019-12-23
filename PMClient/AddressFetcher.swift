//
//  AddressFetcher.swift
//  PMClient
//
//  Created by Frederick Kuhl on 12/20/19.
//  Copyright © 2019 TyndaleSoft LLC. All rights reserved.
//

import Foundation
import Combine

class AddressFetcher: ObservableObject {
    private let fetchingQueue = DispatchQueue(label: "com.tamelea.PMClient.address", qos: .background)
    
    
    @Published public var addresses = [Address]()
    //these need to be ivars, so they don't go out of scope!
    private var publisher: AnyPublisher<[Address], Never>? = nil
    private var sub: Cancellable? = nil

    // MARK: - Singleton
    
    public static let sharedInstance = AddressFetcher()
    private init() {}
    
    func fetch() {
        fetchingQueue.async {
            self.loadData()
        }
    }
    
    func loadData() {
        let url = DataFetcher.url(forCollection: .addresses, operation: .readAll)
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = DataFetcher.readAllBody
        publisher = URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }  //discard HTTP error return
            .decode(type: [Address].self, decoder: jsonDecoder)
            .replaceError(with: []) //dunno bout this
            .eraseToAnyPublisher()
        sub = publisher?
            .receive(on: RunLoop.main)
        .sink(receiveValue: {
            NSLog("fetched \($0.count) addresses")
        })
            //.assign(to: \.addresses, on: self)
    }
}
