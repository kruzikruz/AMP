//
//  Route.swift
//  AMP
//
//  Created by Kornel Krużewski on 03/09/2023.
//

import Foundation
import SwiftUI

enum Route {
    case invalidView
    case matchDetail(Matchs)
    case newsDetial(Posts)
}

extension Route: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashValue)
    }
    
    static func == (lhs: Route, rhs: Route) -> Bool {
        switch (lhs, rhs) {
        case (.invalidView, .invalidView):
            return true
        case (.matchDetail(let lhsItem), .matchDetail(let rhsItem)):
            return lhsItem == rhsItem
        case (.newsDetial(let lhsItem), .newsDetial(let rhsItem)):
            return lhsItem == rhsItem
        default:
            return false
        }
    }
}

extension Route: View {
    
    var body: some View {
        
        switch self {
            
        case .invalidView:
            print("Navigating to InvalidView")
            return AnyView(InvalidView())
        case .matchDetail(let match):
            print("Navigating to MatchDetail")
            return AnyView(MatchDetail(matchs: match))
        case .newsDetial(let posts):
            print("Navigating to NewsDetail")
            return AnyView(NewsDetail(post: posts))
            
        }
    }
}
