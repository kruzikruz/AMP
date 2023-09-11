//
//  TablesAPICall.swift
//  AMP
//
//  Created by Kornel Krużewski on 09/09/2023.
//

import SwiftUI

class TableAPICall: ObservableObject {
    @Published var table: [Table] = []

    func getTable() {
        guard let url = URL(string: "https://amatorkamp.pl/wp-json/sportspress/v2/tables") else { fatalError("Missing URL") }

        let urlRequest = URLRequest(url: url)

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error:", error)
                return
            }

            guard let response = response as? HTTPURLResponse else { return }

            if response.statusCode == 200 {
                guard let data = data else { return }
                print("Received data:", data)
                do {
                    let decodedTable = try JSONDecoder().decode([Table].self, from: data)
                    self.table = decodedTable
                    print("Decoded table:", decodedTable)
                } catch let error {
                    print("Error decoding:", error)
                }
            } else {
                print("Unexpected status code:", response.statusCode)
            }
        }

        dataTask.resume()
        print("Data task started")
    }
}
