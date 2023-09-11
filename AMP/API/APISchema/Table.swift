//
//  Table.swift
//  AMP
//
//  Created by Kornel Krużewski on 09/09/2023.
//

import Foundation

// MARK: - TableElement
struct Table: Codable, Hashable, Identifiable {
    let id: Int
    let data: [String: Datum]
    let date, dateGmt: String?
    let guid: GUID?
    let modified, modifiedGmt, slug, status: String?
    let type: String?
    let link: String?
    let title: GUID?
    let content: Content?
    let featuredMedia, menuOrder: Int?
    let template: String?
    let leagues, seasons: [Int]?
    
    var identifiableId: Int { id }
    
    enum CodingKeys: String, CodingKey {
        case id, data, date
        case dateGmt
        case guid, modified
        case modifiedGmt
        case slug, status, type, link, title, content
        case featuredMedia
        case menuOrder
        case template, leagues, seasons
    }
    
    static var `default`: Table {
        Table(id: 0, data: [:], date: nil, dateGmt: nil, guid: nil, modified: nil, modifiedGmt: nil, slug: nil, status: nil, type: nil, link: nil, title: nil, content: nil, featuredMedia: nil, menuOrder: nil, template: nil, leagues: [116], seasons: nil)
    }
    
    // Implement the Equatable conformance
    static func ==(lhs: Table, rhs: Table) -> Bool {
        return lhs.id == rhs.id && lhs.data == rhs.data
    }
    
    // Implement the Hashable conformance
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(data)
    }
}

// MARK: - Content
struct Content: Codable {
    let rendered: String
    let protected: Bool
}

// MARK: - Datum
struct Datum: Codable, Hashable, Equatable {
    let pos: String
    let name, p, w, d: String
    let l, f, a, gd: String
    let pts: String
    

    static func == (lhs: Datum, rhs: Datum) -> Bool {
        return lhs.pos == rhs.pos && lhs.name == rhs.name && lhs.p == rhs.p && lhs.w == rhs.w && lhs.d == rhs.d && lhs.l == rhs.l && lhs.f == rhs.f && lhs.a == rhs.a && lhs.gd == rhs.gd && lhs.pts == rhs.pts
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let posInt = try? container.decode(Int.self, forKey: .pos) {
            pos = String(posInt)
        } else if let posString = try? container.decode(String.self, forKey: .pos) {
            pos = posString
        } else {
            throw DecodingError.dataCorruptedError(forKey: .pos, in: container, debugDescription: "Invalid value for pos")
        }
        name = try container.decode(String.self, forKey: .name)
        p = try container.decode(String.self, forKey: .p)
        w = try container.decode(String.self, forKey: .w)
        d = try container.decode(String.self, forKey: .d)
        l = try container.decode(String.self, forKey: .l)
        f = try container.decode(String.self, forKey: .f)
        a = try container.decode(String.self, forKey: .a)
        gd = try container.decode(String.self, forKey: .gd)
        pts = try container.decode(String.self, forKey: .pts)
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(pos)
        hasher.combine(name)
        hasher.combine(p)
        hasher.combine(w)
        hasher.combine(d)
        hasher.combine(l)
        hasher.combine(f)
        hasher.combine(a)
        hasher.combine(gd)
        hasher.combine(pts)
    }
}

// MARK: - Pos
enum Pos: Codable, Hashable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Pos.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Pos"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - GUID
struct GUID: Codable {
    let rendered: String
}
