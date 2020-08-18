//
//  TopGames.swift
//  TwitchTest (iOS)
//
//  Created by Emmanuel Tesauro on 11/08/20.
//

import SwiftUI

struct TopGames: Codable {
    var game: Game
    var viewers: Int
    var channels: Int
}
