//
//  PeriMeleonResponse.swift
//  pm-http-server
//
//  Created by Frederick Kuhl on 9/12/19.
//

import Foundation

struct ErrorResponse: Encodable, Decodable {
    let error: String
    let response: String
}
