//
//  RouteFinder.swift
//  AMP
//
//  Created by Kornel Krużewski on 03/09/2023.
//

import Foundation

enum DeepLinkURLs: String {
    case invalidView = "invalidView"
    case match = "match"
    case news = "news"
}

struct RouteFinder {
    
    let singleMatchApiCall = SingleMatchsAPICall()
    let newsApiCall = SinglePostsAPICall()
    
    func find(from url: URL) async -> Route? {
        
        guard let host = url.host else {
            print("Host is missing or invalid in the URL")
            return nil
        }
        
        print("Found host:", host)
        
        var routeToReturn: Route? = nil // Zmienna do śledzenia trasy

        switch DeepLinkURLs(rawValue: host) {
        case .invalidView:
            print("Invalid View URL") // Dodajemy logi
            // Obsługa przypadku invalidView
            return Route.invalidView
            
        case .match:
            print("Obsługa widoku szczegółu meczu") // Obsługa innego widoku
            
            // Sprawdź, czy URL zawiera parametr 'id' i 'type'
            if let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems,
               let idQueryItem = queryItems.first(where: { $0.name == "id" }),
               let id = idQueryItem.value,
               let matchId = Int(id),
               let typeQueryItem = queryItems.first(where: { $0.name == "type" }),
               let type = typeQueryItem.value {
                
                if type == "match" {
                    print("URL zawiera parametry 'id' i 'type' o wartości 'match'")
                    
                    let dispatchGroup = DispatchGroup()
                    
                    dispatchGroup.enter() // Wchodzimy do Dispatch Group
                    
                    singleMatchApiCall.getSingleMatch(matchID: matchId) { match in
                        if let match = match {
                            // Przypisz trasę do zmiennej
                            routeToReturn = .matchDetail(match)
                            print("Pobrano dane meczu: \(match)") // Log
                        } else {
                            // Jeśli nie udało się pobrać danych, przypisz trasę do invalidView
                            routeToReturn = .invalidView
                            print("Nie udało się pobrać danych meczu") // Log
                        }
                        
                        dispatchGroup.leave() // Wychodzimy z Dispatch Group po zakończeniu pobierania danych
                    }
                    
                    // Czekaj na zakończenie pobierania danych
                    dispatchGroup.wait()
                } else {
                    print("Nieobsługiwany typ: \(type)")
                }
            } else {
                print("URL nie zawiera wymaganych parametrów 'id' lub 'type'") // Log
            }
            
        case .news:
            print("Obsługa widoku wiadomości") // Obsługa innego widoku (wiadomości)
            
            // Sprawdź, czy URL zawiera parametr 'id' i 'type'
            if let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems,
               let idQueryItem = queryItems.first(where: { $0.name == "id" }),
               let id = idQueryItem.value,
               let typeQueryItem = queryItems.first(where: { $0.name == "type" }),
               let type = typeQueryItem.value {
                
                if type == "news" {
                    print("URL zawiera parametry 'id' i 'type' o wartości 'news'")
                    
                    let dispatchGroup = DispatchGroup()
                    
                    dispatchGroup.enter() // Wchodzimy do Dispatch Group
                    
                    newsApiCall.getSinglePost(postID: Int(id) ?? 0) { news in
                        if let news = news {
                            routeToReturn = .newsDetial(news)
                            print("Pobrano dane wiadomości: \(news)") // Log
                        } else {
                            routeToReturn = .invalidView
                            print("Nie udało się pobrać danych wiadomości") // Log
                        }
                        dispatchGroup.leave() // Wychodzimy z Dispatch Group po zakończeniu pobierania danych
                    }
                    
                    // Czekaj na zakończenie pobierania danych
                    dispatchGroup.wait()
                } else {
                    print("Nieobsługiwany typ: \(type)")
                }
            } else {
                print("URL nie zawiera wymaganych parametrów 'id' lub 'type'") // Log
            }
        case .none:
            return routeToReturn ?? Route.invalidView
        }

        // Zwróć trasę poza tym przypadkiem lub domyślną trasę
        return routeToReturn ?? Route.invalidView
    }
}
