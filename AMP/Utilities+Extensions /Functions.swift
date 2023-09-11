//
//  Functions.swift
//  AMP
//
//  Created by Kornel Krużewski on 04/09/2023.
//

import Foundation

var DATE_FORMAT = "dd MMM yyyy"

func formatDateShort(_ dateString: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    
    if let date = dateFormatter.date(from: dateString) {
        dateFormatter.dateFormat = "dd/MM"
        return dateFormatter.string(from: date)
    } else {
        return "Invalid Date"
    }
}

extension TeamsAPICall {
    // Funkcja zwracająca nazwę zespołu na podstawie identyfikatora zespołu
    func getTeamName3(for teamId: Int) -> String {
        if let team = teams.first(where: { $0.id == teamId }) {
            return team.title.rendered
        } else {
            return ""
        }
    }
    
    // Extension returning the image URL based on the team identifier
    func getTeamImageURL(for teamId: Int) -> String? {
        if let team = teams.first(where: { $0.id == teamId }) {
            if let ogImage = team.yoast_head_json.og_image.first {
                return ogImage.url
            }
        }
        return nil
    }
}

extension PlayersAPICall {
    func getPlayerNames(forMatch match: Matchs) {
        let playerIDs = match.players
        var playerNames: [String] = []

        let dispatchGroup = DispatchGroup()

        for playerID in playerIDs {
            // Wyklucz identyfikatory zawodników o wartości 0
            if playerID == 0 {
                playerNames.append("")
                continue
            }

            dispatchGroup.enter()
            getPlayerName(forPlayerID: playerID) { playerName in
                playerNames.append(playerName)
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: DispatchQueue.main) {
            // Tutaj możesz przekazać listę nazw zawodników do widoku lub przetworzyć je w dowolny inny sposób
            // Na przykład, przypisz je do odpowiedniego meczu w twojej aplikacji
            print("Nazwy zawodników dla meczu \(match.id): \(playerNames)")

            // Wyświetl nazwy zawodników w konsoli
            for (index, name) in playerNames.enumerated() {
                print("Zawodnik \(index + 1): \(name)")
            }
        }
    }
    
    private func getPlayerName(forPlayerID playerID: Int, completion: @escaping (String) -> Void) {
        let urlString = "https://amatorkamp.pl/wp-json/sportspress/v2/players?include[]=\(playerID)"
        print("Tworzony adres URL: \(urlString)")

        guard let url = URL(string: urlString) else {
            fatalError("Nieprawidłowy adres URL")
        }

        let urlRequest = URLRequest(url: url)

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Błąd żądania: ", error)
                completion("")
                return
            }

            guard let data = data else {
                print("Brak danych w odpowiedzi.")
                completion("")
                return
            }

            if let jsonStr = String(data: data, encoding: .utf8) {
                //print("Odpowiedź JSON: \(jsonStr)")
            }

            do {
                let decodedPlayers = try JSONDecoder().decode([Player].self, from: data)
                print("Dekodowane gracze: \(decodedPlayers)") // Dodaj ten log
                // Tutaj możesz użyć decodedPlayers jako tablicy zawierającej obiekty Player
            } catch let error {
                print("Błąd dekodowania: ", error)
                completion("")
            }
        }


        dataTask.resume()
    }

}




