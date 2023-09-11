//
//  LaunchScreenView.swift
//  AMP
//
//  Created by Kornel Krużewski on 05/09/2023.
//

import SwiftUI

struct LaunchScreenView: View {
    
    @State private var isLoading = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("LanuchScreenViewImage")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .edgesIgnoringSafeArea(.all)
                Circle()
                    .trim(from: 0, to: 0.7)
                    .stroke(Color.green, lineWidth: 5)
                    .frame(width: 50, height: 50)
                    .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                    .animation(Animation.linear(duration: 1.0).repeatForever(autoreverses: false))
                    .onAppear() {
                        self.isLoading = true
                    }

            }
        }
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}

