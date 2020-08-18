//
//  FortniteResponse.swift
//  FindPlayer (iOS)
//
//  Created by Emmanuel Tesauro on 16/08/20.
//

import Foundation

struct FortniteResponse: Codable {
    var epicUserHandle: String
    var avatar: String
    var stats: FortniteGameStats
}

