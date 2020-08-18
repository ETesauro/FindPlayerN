//
//  DataTest.swift
//  TwitchTest (iOS)
//
//  Created by Emmanuel Tesauro on 11/08/20.
//

import Foundation

let gamesData: [TopGames] = [
    
    TopGames(game:
                Game(name: "Call of Duty: Modern Warfare",
                     id: 1,
                     image: "cod"),
                viewers: 100,
                channels: 10
    ),
    TopGames(game:
                Game(name: "Fortnite",
                     id: 2,
                     image: "fortnite"),
                viewers: 100,
                channels: 10
    ),
    TopGames(game:
                Game(name: "Valorant",
                     id: 3,
                     image: "valorant"),
                viewers: 100,
                channels: 10
    ),
    TopGames(game:
                Game(name: "Counter-Strike",
                     id: 4,
                     image: "csgo"),
                viewers: 100,
                channels: 10
    ),
    TopGames(game:
                Game(name: "Fall Guys",
                     id: 5,
                     image: "fallguys"),
                viewers: 100,
                channels: 10
    ),
    TopGames(game:
                Game(name: "Minecraft",
                     id: 6,
                     image: "minecraft"),
                viewers: 100,
                channels: 10
    )
    
]
