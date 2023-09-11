//
//  AMPApp.swift
//  AMP
//
//  Created by Kornel Krużewski on 03/09/2023.
//

import SwiftUI

/// Headline Type
var EMPTY_IMAGE_URL = "https://seferihisar.com/wp-content/themes/shnews/assets/img/no-thumb.jpg"
var NILL_TEXT = "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32.The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham."


@main
struct AMPApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var routerManager = NavigationRouter()
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var dataLoaded = false
    
    @ObservedObject var matchList = MatchsAPICall()
    @ObservedObject var leagueList = LeaguesAPICall()
    @ObservedObject var teamslist = TeamsAPICall()
    @StateObject private var playersAPICall = PlayersAPICall()
    
    var body: some Scene {
        WindowGroup {
            if dataLoaded {
                ContentView()
                    .preferredColorScheme(isDarkMode ? .dark : .light)
                    .environmentObject(routerManager)
                    .environmentObject(MatchsAPICall())
                    .environmentObject(PostsAPICall())
                    .environmentObject(TableAPICall())
                    .environmentObject(TeamsAPICall())
                    .environmentObject(playersAPICall)
                    .onAppear {
                        appDelegate.app = self
                    }
                    .onOpenURL { url in
                        print(url)
                    }
            } else {
                LaunchScreenView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            matchList.getEvents()
                            leagueList.getLeagues()
                            teamslist.getTeams()
                            dataLoaded = true
                        }
                    }
            }
        }
    }
}



extension AMPApp {
    
    func handleDeeplinking(from url: URL) async {
        print("Otrzymany url: \(url)") // Dodajemy log
        
        let routeFinder = RouteFinder()
        if let route = await routeFinder.find(from: url) {
            print("Found route: \(route)") // Dodajemy log
            routerManager.push(to: route)
        } else {
            print("No route found for URL: \(url)") // Dodajemy log
        }
    }
}

