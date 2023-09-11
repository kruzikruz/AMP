//
//  League.swift
//  AMP
//
//  Created by Kornel Krużewski on 03/09/2023.
//

import SwiftUI

struct League: View {
    
    @EnvironmentObject private var routerManager: NavigationRouter
    
    var body: some View {
        NavigationStack(path: $routerManager.routes){
            VStack {
                NavBar(title: "Liga")
                ScrollView(showsIndicators: false){
                    Text("Malbork: Klasa A Grupa 4")
                        .foregroundColor(.white)
                    LeagueTable()
                }
            }
            .navigationDestination(for: Route.self) { $0 }
            .background(Color.black)
        }
    }
}

struct League_Previews: PreviewProvider {
    static var previews: some View {
        League()
    }
}
