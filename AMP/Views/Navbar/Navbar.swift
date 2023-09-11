//
//  Navbar.swift
//  AMP
//
//  Created by Kornel Krużewski on 06/09/2023.
//

import SwiftUI
import Kingfisher

struct NavBar: View {

  let title: String // Dodaj zmienną przechowującą tekst nagłówka

  init(title: String) {
    self.title = title
  }

  var body: some View {
      ZStack {
          HStack {
              KFImage(URL(string: "https://amatorkamp.pl/wp-content/uploads/2022/03/logo@2x-260x300.png"))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 45, height: 45)
              Text(title)
                  .font(Font.custom("Roboto-Bold", size: 28))
                  .foregroundStyle(.white)
              Spacer()
          }
          .padding([.leading, .trailing], 15)
          .padding(.bottom, 7)
          .padding(.top, 10)
      }
      .background(Color(red: 1/255, green: 47/255, blue: 24/255))
  }
}

struct NavBar_Previews: PreviewProvider {
  static var previews: some View {
      NavBar(title: "News")
  }
}
