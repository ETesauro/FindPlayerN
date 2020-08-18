//
//  CODGameStats.swift
//  FindPlayer (iOS)
//
//  Created by Emmanuel Tesauro on 16/08/20.
//

import Foundation

struct CODGameStats: Codable {
    var wins: Int
    var kills: Int
    var kdRatio: Float
    var downs: Int
    var title: String
}
