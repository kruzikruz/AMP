//
//  Post.swift
//  AMP
//
//  Created by Kornel Krużewski on 04/09/2023.
//

import SwiftUI

struct Posts: Codable, Identifiable, Equatable, Hashable {
    let id: Int
    let date: String
    let title: Rendered
    let author: Int
    let slug: String
    let content: Rendered
    let excerpt: Rendered
    let link: String
    let jetpack_featured_media_url: String
    var _embedded: Embedded?
    
    static var `default` : Posts {
        Posts(id: 0, date: "2022-12-18T16:45:09", title: Rendered(rendered: ""), author: 1, slug: "", content: Rendered(rendered: ""), excerpt: Rendered(rendered: ""), link: "", jetpack_featured_media_url: "")
    }
    
    static func ==(lhs: Posts, rhs: Posts) -> Bool {
        return lhs.id == rhs.id && lhs.date == rhs.date && lhs.title == rhs.title && lhs.author == rhs.author && lhs.content == rhs.content && lhs.excerpt == rhs.excerpt && lhs.link == rhs.link && lhs.jetpack_featured_media_url == rhs.jetpack_featured_media_url && lhs._embedded == rhs._embedded
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(date)
        hasher.combine(title)
        hasher.combine(author)
        hasher.combine(content)
        hasher.combine(excerpt)
        hasher.combine(link)
        hasher.combine(jetpack_featured_media_url)
        hasher.combine(_embedded)
    }
}

struct Rendered: Codable, Equatable, Hashable {
    let rendered: String
    
    static func ==(lhs: Rendered, rhs: Rendered) -> Bool {
        return lhs.rendered == rhs.rendered
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(rendered)
    }
}

struct Embedded: Codable, Equatable, Hashable {
    enum CodingKeys: String, CodingKey {
        case featuredmedia = "wp:featuredmedia"
    }
    var featuredmedia: [Media]?
    
    static func ==(lhs: Embedded, rhs: Embedded) -> Bool {
        return lhs.featuredmedia == rhs.featuredmedia
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(featuredmedia)
    }
}

struct Media: Codable, Equatable, Hashable {
    var source_url: String?
    var media_details: MediaDetails?
    
    static func ==(lhs: Media, rhs: Media) -> Bool {
        return lhs.source_url == rhs.source_url && lhs.media_details == rhs.media_details
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(source_url)
        hasher.combine(media_details)
    }
}

struct MediaDetails: Codable, Equatable, Hashable {
    var sizes: MediaSizes?
    
    static func ==(lhs: MediaDetails, rhs: MediaDetails) -> Bool {
        return lhs.sizes == rhs.sizes
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(sizes)
    }
}

struct MediaSizes: Codable, Equatable, Hashable {
    var medium: MediaSize?
    
    static func ==(lhs: MediaSizes, rhs: MediaSizes) -> Bool {
        return lhs.medium == rhs.medium
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(medium)
    }
}

struct MediaSize: Codable, Equatable, Hashable {
    var source_url: String?
    
    static func ==(lhs: MediaSize, rhs: MediaSize) -> Bool {
        return lhs.source_url == rhs.source_url
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(source_url)
    }
}

