//
//  DataFetcher.swift
//  PMClient
//
//  Created by Frederick Kuhl on 12/20/19.
//  Copyright © 2019 TyndaleSoft LLC. All rights reserved.
//

import Foundation

class DataFetcher {
    fileprivate let dataServerHost = "localhost"
    fileprivate let dataServerPort = 8123
    fileprivate let readAllBody = try! jsonEncoder.encode("{}")
    
    public var members = [Member]()

    // MARK: - Singleton
    
    public static let sharedInstance = DataFetcher()
    private init() {}
    

    func loadData() {
        let url = URL(string: "http://\(dataServerHost):\(dataServerPort)/\(CollectionName.members.rawValue)/\(CrudOperation.readAll.rawValue)")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = readAllBody
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                NSLog("error on call: \(error)")
                return
            }
            //could check HTTP status too
            //check mime type?
            guard data != nil else {
                NSLog("no data returned")
                return
            }
            do {
                self.members = try jsonDecoder.decode([Member].self, from: data!)
                NSLog("succeded with \(self.members.count) Members")
            } catch {
                NSLog("error decoding response: \(error.localizedDescription)")
                return
            }
        }
        task.resume()
    }
}
