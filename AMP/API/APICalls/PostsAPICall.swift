//
//  PostsAPICall.swift
//  AMP
//
//  Created by Kornel Krużewski on 04/09/2023.
//

import SwiftUI

class PostsAPICall: ObservableObject {
    @Published var posts: [Posts] = []
    
    // MARK: - Events
    
    func getPosts() {
        guard let url = URL(string: "https://amatorkamp.pl/wp-json/wp/v2/posts") else { fatalError("Missing URL") }

        let urlRequest = URLRequest(url: url)

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }

            guard let response = response as? HTTPURLResponse else { return }

            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decodedPosts = try JSONDecoder().decode([Posts].self, from: data)
                        self.posts = decodedPosts
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }

        dataTask.resume()
    }
}
