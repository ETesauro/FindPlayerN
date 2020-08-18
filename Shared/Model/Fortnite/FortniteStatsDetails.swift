//
//  FortniteStatsDetail.swift
//  FindPlayer (iOS)
//
//  Created by Emmanuel Tesauro on 16/08/20.
//

import Foundation

struct FortniteStatsDetails: Codable {
    // Vittorie
    var top1: FortniteCategoryDetails
    
    // Numero di match
    var matches: FortniteCategoryDetails
    
    // Vittorie/Sconfitte
    var winRatio: FortniteCategoryDetails
    
    // Kills
    var kills: FortniteCategoryDetails
    
    // Kill/Morti
    var kd: FortniteCategoryDetails
}
