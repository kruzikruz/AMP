//
//  ContentView.swift
//  AMP
//
//  Created by Kornel Krużewski on 16/04/2023.
//

import Foundation
import SwiftUI
struct ContentView: View {
    
    @State private var match: String = ""
    @State private var rendered: String = ""

    var body: some View {
        Text(match)
        
        
        Button {
            Task {
                let (data, _) = try await URLSession.shared.data(from: URL(string:"https://amatorkamp.pl/wp-json/sportspress/v2/events/5430")!)
                let decodedResponse = try? JSONDecoder().decode(Match.self, from: data)
                match = decodedResponse?.status ?? ""
            }
        } label: {
            Text("Pokaż mecz")
        }
        
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct MatchTitle: Decodable {
    let rendered: String
    
}

struct Match: Decodable {
    let status: String
    let title: [MatchTitle]
}






