//
//  ModelData.swift
//  Pull to Refresh
//
//  Created by Abdul R. Arraisi on 27/12/20.
//

import Foundation

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}
