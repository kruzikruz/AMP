//
//  Home.swift
//  AMP
//
//  Created by Kornel Krużewski on 03/09/2023.
//

import SwiftUI

struct Home: View {
    
    @EnvironmentObject private var routerManager: NavigationRouter
    
    var body: some View {
        NavigationStack(path: $routerManager.routes){
            VStack{
                Text("Home")                
            }
            .navigationDestination(for: Route.self) { $0 }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environmentObject(NavigationRouter())
    }
}
