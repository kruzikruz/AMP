//
//  Match.swift
//  AMP
//
//  Created by Kornel Krużewski on 03/09/2023.
//

import Foundation

struct Matchs: Identifiable, Decodable {
    let id: Int
    let date: String
    var title: Title
    var status: String
    var slug: String
    var author: Int
    var leagues: [Int]
    var seasons: [Int]
    var featured_media: Int
    var format: String
    var day: String
    var teams: [Int]
    var players: [Int]
    var main_results: [String]
    
    static var `default`: Matchs {
        Matchs(id: 0, date: "2018-01-01T00:00:00", title: Title(rendered: ""), status: "", slug: "1", author: 1,leagues: [0], seasons: [0], featured_media: 1, format: "", day: "", teams: [0], players: [], main_results: [])
    }
    
    struct Title: Decodable {
        var rendered: String
    }
}


extension Matchs: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Matchs, rhs: Matchs) -> Bool {
        return lhs.id == rhs.id
    }
}
