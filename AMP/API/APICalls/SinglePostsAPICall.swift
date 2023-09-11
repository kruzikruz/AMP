//
//  SinglePostsAPICall.swift
//  AMP
//
//  Created by Kornel Krużewski on 05/09/2023.
//

import Foundation

class SinglePostsAPICall: ObservableObject {
    // MARK: - Events
    
    func getSinglePost(postID: Int, completion: @escaping (Posts?) -> Void) {
        // Tworzymy URL na podstawie identyfikatora wiadomości
        guard let url = URL(string: "https://amatorkamp.pl/wp-json/wp/v2/posts/\(postID)") else {
            print("Invalid URL")
            completion(nil)
            return
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
                    let decodedPost = try JSONDecoder().decode(Posts.self, from: data)
                    DispatchQueue.main.async {
                        completion(decodedPost)
                    }
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
