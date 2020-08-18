//
//  Game.swift
//  TwitchTest (iOS)
//
//  Created by Emmanuel Tesauro on 11/08/20.
//

import SwiftUI

struct Game: Codable, Identifiable {
    var uuid = UUID()
    var name: String
    var id: Int
    var image: String
//    var box: LogoImage
}

struct LogoImage: Codable {
    var large: String
    var medium: String
    var small: String
}
