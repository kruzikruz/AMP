//
//  LeagueData.swift
//  AMP
//
//  Created by Kornel Krużewski on 05/09/2023.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let leagueData = try? JSONDecoder().decode(LeagueData.self, from: jsonData)

import Foundation

// MARK: - LeagueDatum
struct LeagueData: Codable {
    let id: Int
    let count: Int
    let description: String
    let link: String
    let name: String
    let slug: String
    let taxonomy: String
    let parent: Int
    let meta: [JSONAny]
    let yoastHead: String?
    let yoastHeadjson: YoastHeadjson?
    let links: Links?

    enum CodingKeys: String, CodingKey {
        case id
        case count
        case description
        case link
        case name
        case slug
        case taxonomy
        case parent
        case meta
        case yoastHead
        case yoastHeadjson
        case links
    }
}

// MARK: - Links
struct Links: Codable {
    let linksSelf: [About]
    let collection: [About]
    let about: [About]
    let wpPostType: [About]
    let curies: [Cury]

    enum CodingKeys: String, CodingKey {
        case linksSelf
        case collection
        case about
        case wpPostType
        case curies
    }
}

// MARK: - About
struct About: Codable {
    let href: String

    enum CodingKeys: String, CodingKey {
        case href
    }
}

// MARK: - Cury
struct Cury: Codable {
    let name: String
    let href: String
    let templated: Bool

    enum CodingKeys: String, CodingKey {
        case name
        case href
        case templated
    }
}

// MARK: - YoastHeadjson
struct YoastHeadjson: Codable {
    let title: String
    let robots: Robots
    let canonical: String
    let ogLocale: String
    let ogType: String
    let ogTitle: String
    let ogDescription: String?
    let ogurl: String
    let ogSiteName: String
    let twitterCard: String
    let schema: Schema

    enum CodingKeys: String, CodingKey {
        case title
        case robots
        case canonical
        case ogLocale
        case ogType
        case ogTitle
        case ogDescription
        case ogurl
        case ogSiteName
        case twitterCard
        case schema
    }
}

// MARK: - Robots
struct Robots: Codable {
    let index: String
    let follow: String
    let maxSnippet: String
    let maxImagePreview: String
    let maxVideoPreview: String

    enum CodingKeys: String, CodingKey {
        case index
        case follow
        case maxSnippet
        case maxImagePreview
        case maxVideoPreview
    }
}

// MARK: - Schema
struct Schema: Codable {
    let context: String
    let graph: [Graph]

    enum CodingKeys: String, CodingKey {
        case context
        case graph
    }
}

// MARK: - Graph
struct Graph: Codable {
    let type: String
    let id: String
    let url: String?
    let name: String?
    let isPartOf: Breadcrumb?
    let breadcrumb: Breadcrumb?
    let inLanguage: String?
    let itemListElement: [ItemListElement]?
    let description: String?
    let potentialAction: [PotentialAction]?

    enum CodingKeys: String, CodingKey {
        case type
        case id
        case url
        case name
        case isPartOf
        case breadcrumb
        case inLanguage
        case itemListElement
        case description
        case potentialAction
    }
}

// MARK: - Breadcrumb
struct Breadcrumb: Codable {
    let id: String

    enum CodingKeys: String, CodingKey {
        case id
    }
}

// MARK: - ItemListElement
struct ItemListElement: Codable {
    let type: String
    let position: Int
    let name: String
    let item: String?

    enum CodingKeys: String, CodingKey {
        case type
        case position
        case name
        case item
    }
}

// MARK: - PotentialAction
struct PotentialAction: Codable {
    let type: String
    let target: Target
    let queryInput: String

    enum CodingKeys: String, CodingKey {
        case type
        case target
        case queryInput
    }
}

// MARK: - Target
struct Target: Codable {
    let type: String
    let urlTemplate: String

    enum CodingKeys: String, CodingKey {
        case type
        case urlTemplate
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}

