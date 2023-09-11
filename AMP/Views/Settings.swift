//
//  Settings.swift
//  AMP
//
//  Created by Kornel Krużewski on 03/09/2023.
//

import SwiftUI

struct Settings: View {
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    @EnvironmentObject private var routerManager: NavigationRouter
    
    var body: some View {
        NavigationStack(path: $routerManager.routes){
            VStack{
            NavBar(title: "Ustawienia")
            }
            Form {
                Section(header: Text("Ekran"), footer: Text("Ustawienie systemowe zastąpi tryb ciemny i użyje bieżącego motywu urządzenia.")){
                    
                    Toggle(isOn: $isDarkMode,
                           label: {
                        Text("Dark mode")
                    })
                    
                    Toggle(isOn: .constant(true),
                           label: {
                        Text("Powiadomienia")
                    })
                }
                
                Section(header: Text("Social media")) {
                    Link(destination: URL(string: "https://www.facebook.com/AmatorkaMP")!) {
                        Label("Polub nas na Facebook'u", systemImage: "link")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .imageScale(.large)
                    }
                    Link(destination: URL(string: "https://www.youtube.com/@amatorkamikoajkipomorskie2438/featured")!) {
                        Label("Polub nas na Youtube", systemImage: "link")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .imageScale(.large)
                    }
                }

                
            }
            .navigationDestination(for: Route.self) { $0 }
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
