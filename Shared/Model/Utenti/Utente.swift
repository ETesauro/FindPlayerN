//
//  Utente.swift
//  FindPlayer (iOS)
//
//  Created by Emmanuel Tesauro on 19/08/2020.
//

import Foundation

struct Utente: Codable {
    var name: String
    var surname: String
    var email: String
}

struct UtentiRisposta: Codable {
    var users: [Utente]
}
