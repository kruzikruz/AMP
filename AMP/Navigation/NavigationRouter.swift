//
//  NavigationRouter.swift
//  AMP
//
//  Created by Kornel Krużewski on 03/09/2023.
//

import Foundation
import SwiftUI

final class NavigationRouter: ObservableObject {
    
    @Published var routes = [Route]()
    
    func push(to screen: Route) {
        guard !routes.contains(screen) else {
            return
        }
        routes.append(screen)
        
        // Log operacji nawigacyjnej
        print("Pushed to screen: \(screen)")
    }
    
    func goBack() {
        if let poppedRoute = routes.popLast() {
            // Log operacji nawigacyjnej
            print("Popped from screen: \(poppedRoute)")
        }
    }
    
    func reset() {
        routes = []
        
        // Log operacji nawigacyjnej
        print("Reset navigation stack")
    }
    
    func replace(stack: [Route]) {
        routes = stack
        
        // Log operacji nawigacyjnej
        print("Replaced navigation stack with: \(stack)")
    }
}
