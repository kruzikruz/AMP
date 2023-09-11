//
//  MatchDetail.swift
//  AMP
//
//  Created by Kornel Krużewski on 03/09/2023.
//

import SwiftUI

struct MatchDetail: View {
    let matchs: Matchs
    @EnvironmentObject var playersAPICall: PlayersAPICall

    @State private var playerNames: [String] = []
    @State private var isLoading = true

    var body: some View {
        ScrollView(showsIndicators: false){
            VStack {
                Text("Mecz")
                Text("Tytuł meczu: \(matchs.title.rendered)")
                Text("Slug: \(matchs.slug)")

                // Wyświetl nazwy zawodników
                ForEach(playerNames, id: \.self) { playerName in
                    Text("Nazwa zawodnika: \(playerName)")
                }
            }
        }
        .task {
            // Wywołaj pobieranie danych na starcie widoku
            playersAPICall.getPlayerNames(forMatch: matchs)
        }
        .onReceive(playersAPICall.$decodedPlayers, perform: { decodedPlayers in
            // Aktualizuj stan widoku po odebraniu danych
            playerNames = decodedPlayers.map { $0.slug }
            isLoading = false
            print("Odebrano dane zawodników: \(decodedPlayers)")
        })
    }
}







struct MatchDetail_Previews: PreviewProvider {
    static var previews: some View {
        MatchDetail(matchs: Matchs.default)
    }
}

