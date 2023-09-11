//
//  Team.swift
//  AMP
//
//  Created by Kornel Krużewski on 09/09/2023.
//

import Foundation

// MARK: - Teams
struct Team_API_DATA: Identifiable, Decodable {
    let id: Int
    let date: String
    let slug: String
    let status: String
    let type: String
    let link: String
    let title: TeamName
    let content: ContentText
    let yoast_head: String
    let yoast_head_json: YoastHeadJSON
    let bacgroundimage_url: String
    static var `default`: Team_API_DATA {
        Team_API_DATA(id: 0, date: "2022-12-18T16:45:09", slug: "1", status: "", type: "", link: "", title: TeamName(rendered: ""), content: ContentText(rendered: ""), yoast_head: "", yoast_head_json: YoastHeadJSON(title: "", robots: [:], canonical: "", og_locale: "", og_type: "", og_image: []), bacgroundimage_url: "Artwork")
    }
    
    struct TeamName: Codable {
        let rendered: String
    }
    
    struct ContentText: Codable {
        let rendered: String
    }
    
    struct YoastHeadJSON: Codable {
            let title: String
            let robots: [String: String]
            let canonical: String
            let og_locale: String
            let og_type: String
            // ...
            let og_image: [OGImage]
            
            struct OGImage: Codable {
                let width: Int
                let height: Int
                let url: String
                let type: String
            }
        }
}

