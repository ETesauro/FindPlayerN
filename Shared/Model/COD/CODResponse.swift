//
//  CODResponse.swift
//  FindPlayer (iOS)
//
//  Created by Emmanuel Tesauro on 16/08/20.
//

import Foundation

struct CODResponse: Codable {
    // Battle Royale
    var br: CODGameStats
    
    // Malloppo
    var br_dmz: CODGameStats
    
    //Totale
    var br_all: CODGameStats
}
