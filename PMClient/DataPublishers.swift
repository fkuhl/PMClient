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
                let message = String(data: data, encoding: .utf8) ?? "[no response]"
                let status = (response as? HTTPURLResponse)?.statusCode ?? 0
                let log = "(\(status)) \(message)"
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
    request.httpBody = try! jsonEncoder.encode(newValue)
    return URLSession.shared.dataTaskPublisher(for: request)
        .tryMap {
            data, response in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                let message = String(data: data, encoding: .utf8) ?? "[no response]"
                let status = (response as? HTTPURLResponse)?.statusCode ?? 0
                let log = "(\(status)) \(message)"
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

func addPublisher(_ newValue: Household, dataServerHost: String, dataServerPort: Int) -> AnyPublisher<String, CallError> {
    var request = URLRequest(url: URL(string: "http://\(dataServerHost):\(dataServerPort)\(Endpoint.households.rawValue)")!)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    request.httpBody = try! jsonEncoder.encode(newValue)
    return URLSession.shared.dataTaskPublisher(for: request)
        .tryMap {
            data, response in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                let message = String(data: data, encoding: .utf8) ?? "[no response]"
                let status = (response as? HTTPURLResponse)?.statusCode ?? 0
                let log = "(\(status)) \(message)"
                NSLog("client got err resp: \(log)")
                throw CallError(errorString: "add household failed", reason: log)
            }
            guard let newId = String(data: data, encoding: .utf8) else {
                let log = "error decoding response"
                NSLog("client got err resp: \(log)")
                throw CallError(errorString: "add household failed", reason: log)
            }
            return newId
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
