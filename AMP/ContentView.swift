//
//  ContentView.swift
//  AMP
//
//  Created by Kornel Krużewski on 03/09/2023.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var routerManager: NavigationRouter
    @State private var selectedTab = "Home"
    
    var body: some View {
            TabView(selection: $selectedTab) {
                Home()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    .tag("Home")
                Match()
                    .tabItem {
                        Label("Mecze", systemImage: "soccerball")
                    }
                    .tag("Match")
                League()
                    .tabItem {
                        Label("Tabela", systemImage: "table")
                    }
                    .tag("League")
                News()
                    .tabItem {
                        Label("News", systemImage: "newspaper")
                    }
                    .tag("News")
                Settings()
                    .tabItem {
                        Label("Settings", systemImage: "gearshape")
                    }
                    .tag("Settings")
            }
            .accentColor(.green)
            .onAppear() {
                let appearance = UITabBarAppearance()
                appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
                appearance.backgroundColor = UIColor(Color.black.opacity(0.9))
                
                // Use this appearance when scrolling behind the TabView:
                UITabBar.appearance().standardAppearance = appearance
                // Use this appearance when scrolled all the way up:
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(NavigationRouter())
    }
}
