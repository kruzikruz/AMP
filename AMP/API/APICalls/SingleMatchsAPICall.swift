//
//  SingleMatchsAPICall.swift
//  AMP
//
//  Created by Kornel Krużewski on 04/09/2023.
//

import SwiftUI

class SingleMatchsAPICall: ObservableObject {
    @Published var singleMatch: Matchs?
    
    // MARK: - Single Match
    
    func getSingleMatch(matchID: Int, completion: @escaping (Matchs?) -> Void) {
        guard let url = URL(string: "https://amatorkamp.pl/wp-json/sportspress/v2/events/\(matchID)") else {
            fatalError("Invalid URL")
        }
        
        let urlRequest = URLRequest(url: url)

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                completion(nil)
                return
            }

            guard let response = response as? HTTPURLResponse else {
                completion(nil)
                return
            }

            if response.statusCode == 200 {
                guard let data = data else {
                    completion(nil)
                    return
                }
                
                do {
                    let decodedMatch = try JSONDecoder().decode(Matchs.self, from: data)
                    completion(decodedMatch)
                } catch let error {
                    print("Error decoding: ", error)
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }

        dataTask.resume()
    }
}
