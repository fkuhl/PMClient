//
//  DataPublishers.swift
//  PMClient
//
//  Created by Frederick Kuhl on 1/11/20.
//  Copyright © 2020 TyndaleSoft LLC. All rights reserved.
//

import Foundation
import Combine
import PMDataTypes

func readAllPublisher(dataServerHost: String, dataServerPort: Int) -> AnyPublisher<[Household], CallError> {
    var request = URLRequest(url: URL(string: "http://\(dataServerHost):\(dataServerPort)\(Endpoint.households.rawValue)?scope=all")!)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "GET"
    request.httpBody = nil
    return URLSession.shared.dataTaskPublisher(for: request)
        .tryMap {
            data, response in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                let log = String(data: data, encoding: .utf8) ?? "nada"
                NSLog("client got err resp: \(log)")
                throw CallError(errorString: "read all households failed", reason: log)
            }
            do {
                let documents = try jsonDecoder.decode([Household].self, from: data)
                return documents
            } catch {
                throw CallError(errorString: error.localizedDescription, reason: "client decode of Household failed")
            }
        }
        .mapError {
            error in
            if let error = error as? CallError { return error }
            return CallError(errorString: error.localizedDescription, reason: "Server not running?")
        }
        .eraseToAnyPublisher()
}

func updatePublisher(to newValue: Household, dataServerHost: String, dataServerPort: Int) -> AnyPublisher<Void, CallError> {
    var request = URLRequest(url: URL(string: "http://\(dataServerHost):\(dataServerPort)\(Endpoint.households.rawValue)?id=\(newValue.id)")!)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "PUT"
    request.httpBody = try! jsonEncoder.encode(newValue) //TODO hmmm
    return URLSession.shared.dataTaskPublisher(for: request)
        .tryMap {
            data, response in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                let log = String(data: data, encoding: .utf8) ?? "nada"
                NSLog("client got err resp: \(log)")
                throw CallError(errorString: "update household failed", reason: log)
            }
    }
    .mapError {
        error in
        if let error = error as? CallError { return error }
        else { return CallError(errorString: error.localizedDescription, reason: "some unk err")}
    }
    .eraseToAnyPublisher()
}



struct CallError: Error {
    let errorString: String
    let reason: String
}
