//
//  LeaguesAPICall.swift
//  AMP
//
//  Created by Kornel Krużewski on 05/09/2023.
//

import SwiftUI

class LeaguesAPICall: ObservableObject {
    @Published var leagues: [LeagueData] = []
    
    // MARK: - Leagues
    
    func getLeagues() {
        var allLeagues: [LeagueData] = []
        
        DispatchQueue.global().async {
            self.fetchLeagues(page: 1) { leagues, totalPages in
                allLeagues.append(contentsOf: leagues)
                
                if totalPages > 1 {
                    for page in 2...totalPages {
                        self.fetchLeagues(page: page) { leagues, _ in
                            allLeagues.append(contentsOf: leagues)
                            
                            if page == totalPages {
                                DispatchQueue.main.async {
                                    self.leagues = allLeagues
                                }
                            }
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.leagues = allLeagues
                    }
                }
            }
        }
    }
    
    private func fetchLeagues(page: Int, completion: @escaping ([LeagueData], Int) -> Void) {
        guard var urlComponents = URLComponents(string: "https://amatorkamp.pl/wp-json/sportspress/v2/leagues") else {
            fatalError("Missing URL")
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "per_page", value: "100"), // liczba wyników na stronie
            URLQueryItem(name: "page", value: String(page)) // numer strony
        ]
        
        guard let url = urlComponents.url else {
            fatalError("Invalid URL components")
        }
        
        let urlRequest = URLRequest(url: url)

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                completion([], 0)
                return
            }

            guard let response = response as? HTTPURLResponse else {
                completion([], 0)
                return
            }

            if response.statusCode == 200 {
                guard let data = data else {
                    completion([], 0)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let decodedLeagues = try decoder.decode([LeagueData].self, from: data)
                    let totalPages = response.allHeaderFields["X-WP-TotalPages"] as? Int ?? 0
                    completion(decodedLeagues, totalPages)
                } catch let error {
                    print("Error decoding: ", error)
                    completion([], 0)
                }
            } else {
                completion([], 0)
            }
        }

        dataTask.resume()
    }
}

