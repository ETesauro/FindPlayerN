//
//  FortniteGameStats.swift
//  FindPlayer (iOS)
//
//  Created by Emmanuel Tesauro on 16/08/20.
//

import Foundation

struct FortniteGameStats: Codable {
    
    // p2 = solo
    var p2: FortniteStatsDetails
    
    // p10 = duo
    var p10: FortniteStatsDetails
    
    // p9 = team
    var p9: FortniteStatsDetails
}
