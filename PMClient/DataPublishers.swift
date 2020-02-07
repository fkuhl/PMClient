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

func readAllPublisher<D: DataType>(collection: CollectionName) -> AnyPublisher<[D], CallError> {
    var request = URLRequest(url: DataFetcher.url(forCollection: collection, operation: .readAll))
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    request.httpBody = DataFetcher.readAllBody
    return URLSession.shared.dataTaskPublisher(for: request)
        .tryMap {
            data, response in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                let log = String(data: data, encoding: .utf8)
                NSLog("client got err resp: \(log ?? "nada")")
                let errorResponse = try jsonDecoder.decode(ErrorResponse.self, from: data)
                NSLog("client decoded err resp, err: \(errorResponse.error), response: \(errorResponse.response)")
                throw CallError(errorString: errorResponse.error, reason: errorResponse.response)
            }
            do {
                let documents = try jsonDecoder.decode([D].self, from: data)
                return documents
            } catch {
                throw CallError(errorString: error.localizedDescription, reason: "client decode of \(collection) failed")
            }
        }
        .mapError {
            error in
            if let error = error as? CallError { return error }
            else { return CallError(errorString: error.localizedDescription, reason: "some unk err")}
        }
        .eraseToAnyPublisher()
}

func updatePublisher<D: DataType>(collection: CollectionName, to newValue: D) -> AnyPublisher<D, CallError> {
    var request = URLRequest(url: DataFetcher.url(forCollection: collection, operation: .update))
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    request.httpBody = try! jsonEncoder.encode(newValue) //TODO hmmm
    return URLSession.shared.dataTaskPublisher(for: request)
        .tryMap {
            data, response in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { //TODO respond to NOTFOUND?
                let log = String(data: data, encoding: .utf8)
                NSLog("client got err resp: \(log ?? "nada")")
                let errorResponse = try jsonDecoder.decode(ErrorResponse.self, from: data)
                NSLog("client decoded err resp, err: \(errorResponse.error), response: \(errorResponse.response)")
                throw CallError(errorString: errorResponse.error, reason: errorResponse.response)
            }
            do {
                let updated = try jsonDecoder.decode(D.self, from: data)
                return updated
            } catch {
                throw CallError(errorString: error.localizedDescription, reason: "client decode of \(collection) failed")
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
