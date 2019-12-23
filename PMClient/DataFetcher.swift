//
//  DataFetcher.swift
//  PMClient
//
//  Created by Frederick Kuhl on 12/23/19.
//  Copyright © 2019 TyndaleSoft LLC. All rights reserved.
//

import Foundation

class DataFetcher {
    private static let dataServerHost = "localhost"
    private static let dataServerPort = 8123
    static let readAllBody = try! jsonEncoder.encode("{}")
    
    static func url(forCollection: CollectionName, operation: CrudOperation) -> URL {
        return URL(string: "http://\(dataServerHost):\(dataServerPort)/\(forCollection.rawValue)/\(operation.rawValue)")!
    }

}
