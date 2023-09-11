//
//  InvalidView.swift
//  AMP
//
//  Created by Kornel Krużewski on 03/09/2023.
//

import SwiftUI

struct InvalidView: View {
        
    var body: some View {
        VStack {
            Text("😱")
                .font(.system(size: 100))
            Text("Invalid View")
                .font(.largeTitle)
                .bold()
            Text("Looks like that item doesn't exist anymore")
        }
    }
}

struct InvalidView_Previews: PreviewProvider {
    static var previews: some View {
        InvalidView()
    }
}
