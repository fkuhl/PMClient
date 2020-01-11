//
//  AddressFetcher.swift
//  PMClient
//
//  Created by Frederick Kuhl on 12/20/19.
//  Copyright © 2019 TyndaleSoft LLC. All rights reserved.
//

import Foundation
import Combine
import PMDataTypes

class AddressFetcher: ObservableObject {
    private let fetchingQueue = DispatchQueue(label: "com.tamelea.PMClient.address", qos: .background)
    
    
    @Published public var addresses = [Address]() {
        didSet {
            addressesById = [Id : Address]()
            for address in addresses { addressesById[address.id] = address }
        }
    }
    public var addressesById = [Id : Address]()
    
    //these need to be ivars, so they don't go out of scope!
    private var publisher: AnyPublisher<[Address], CallError>? = nil
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
        publisher = readAllPublisher(collection: .addresses)
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
            }, receiveValue: { addresses in
                self.addresses = addresses
            })
    }
}
