//
//  DataFetcher.swift
//  PMClient
//
//  Created by Frederick Kuhl on 12/20/19.
//  Copyright © 2019 TyndaleSoft LLC. All rights reserved.
//

import Foundation
import Combine

class DataFetcher: ObservableObject {
    fileprivate let dataServerHost = "localhost"
    fileprivate let dataServerPort = 8123
    fileprivate let readAllBody = try! jsonEncoder.encode("{}")
    
    @Published public var members = [Member]()
    //these need to be ivars, so they don't go out of scoope!
    private var publisher: AnyPublisher<[Member], Never>? = nil
    private var sub: Cancellable? = nil

    // MARK: - Singleton
    
    public static let sharedInstance = DataFetcher()
    private init() {}
    

    func loadData() {
        let url = URL(string: "http://\(dataServerHost):\(dataServerPort)/\(CollectionName.members.rawValue)/\(CrudOperation.readAll.rawValue)")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = readAllBody
        publisher = URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: [Member].self, decoder: jsonDecoder)
            .replaceError(with: []) //dunno bout this
            .eraseToAnyPublisher()
        sub = publisher?
            .receive(on: RunLoop.main)
            .assign(to: \.members, on: self)
//            .sink(receiveValue: { members in
//                NSLog("sunk update of \(members.count) members")
//            })
        
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                NSLog("error on call: \(error)")
//                return
//            }
//            //could check HTTP status too
//            //check mime type?
//            guard data != nil else {
//                NSLog("no data returned")
//                return
//            }
//            do {
//                self.members = try jsonDecoder.decode([Member].self, from: data!)
//                NSLog("succeded with \(self.members.count) Members")
//            } catch {
//                NSLog("error decoding response: \(error.localizedDescription)")
//                return
//            }
//        }
//        task.resume()
    }
}
