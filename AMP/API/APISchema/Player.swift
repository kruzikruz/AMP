//
//  Player.swift
//  AMP
//
//  Created by Kornel Krużewski on 10/09/2023.
//

import Foundation

// MARK: - Struktura Player
struct Player: Decodable {
    let id: Int
    let slug: String
    
    // Pozostałe właściwości zawodnika
    
    enum CodingKeys: String, CodingKey {
        case id, slug
    }
}

struct PlayersResponse: Decodable {
    let players: [Player]
}



