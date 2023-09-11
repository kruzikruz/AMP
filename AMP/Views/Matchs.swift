//
//  Matchs.swift
//  AMP
//
//  Created by Kornel Krużewski on 03/09/2023.
//

import SwiftUI
import Kingfisher

struct Match: View {
    
    @ObservedObject var matchList = MatchsAPICall()
    @ObservedObject var leagueList = LeaguesAPICall()
    @ObservedObject var teamsName = TeamsAPICall()

    
    @EnvironmentObject private var routerManager: NavigationRouter

    @State private var selectedDay: String = "All"
    
    var body: some View {
            NavigationStack(path: $routerManager.routes) {
              VStack{
                NavBar(title: "Terminarz")
                ScrollView(showsIndicators: false) {
                    VStack{
                        Text("Match")
                        
                        Picker("Select Day", selection: $selectedDay) {
                            Text("All").tag("All") // Dodaj opcję "All" do wyboru
                            ForEach(getUniqueDays(from: matchList.events), id: \.self) { day in
                                Text("\(day)").tag(day)
                            }
                        }
                        .pickerStyle(.menu)
                        ForEach(leagueList.leagues, id: \.id) { league in
                            let matchingEvents = matchList.events.filter { $0.seasons.contains(135) && $0.leagues.contains(league.id) && (selectedDay == "All" || $0.day == selectedDay) }
                            
                            if !matchingEvents.isEmpty {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Image("A-Klasa")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 25)
                                        
                                        VStack {
                                            Text(league.name)
                                                .foregroundStyle(.white)
                                        }
                                    }
                                    VStack {
                                        ForEach(matchingEvents, id: \.id) { event in
                                            NavigationLink(destination: MatchDetail(matchs: event)) {
                                                VStack(alignment: .leading) {
                                                    MatchCard(
                                                        TEAM1: teamsName.getTeamName3(for: event.teams[0]),
                                                        TEAM2: teamsName.getTeamName3(for: event.teams[1]),
                                                        TIME: "21:00",
                                                        TEAM1_BADGE: teamsName.getTeamImageURL(for: event.teams[0]) ?? "defaultbadge",
                                                        TEAM2_BADGE: teamsName.getTeamImageURL(for: event.teams[1]) ?? "defaultbadge"
                                                    )
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .background(Color.black)
                    .onAppear {
                        print("View appeared")
                        matchList.getEvents()
                        leagueList.getLeagues()
                        teamsName.getTeams()// Dodane pobieranie lig
                        print("getEvents() called")
                        print("MatchList.events count: \(matchList.events.count)")
                        print("LeagueList.leagues count: \(leagueList.leagues.count)") // Dodane wyświetlenie liczby lig
                    }
                }
            }
            .navigationDestination(for: Route.self) { $0 }
            .background(Color.black)
        }
    }
    
    // Funkcja, która zwraca unikalne dni z listy wydarzeń
        private func getUniqueDays(from events: [Matchs]) -> [String] {
            let uniqueDays = Array(Set(events.map { $0.day }))
            return uniqueDays.sorted()
        }
}

struct Match_Previews: PreviewProvider {
    static var previews: some View {
        Match()
            .environmentObject(NavigationRouter())
            .environmentObject(MatchsAPICall())
            .environmentObject(LeaguesAPICall())
            .environmentObject(TeamsAPICall())
    }
}
