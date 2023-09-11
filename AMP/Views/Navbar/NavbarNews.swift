//
//  NavbarNews.swift
//  AMP
//
//  Created by Kornel Krużewski on 06/09/2023.
//


import SwiftUI
import Kingfisher

struct NavBarNews: View {

  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
    let share_url: String

    init(share_url: String) {
      self.share_url = share_url
    }
    
  var body: some View {
      ZStack {
          HStack {
              Button(action: {
                  self.presentationMode.wrappedValue.dismiss()
              }) {
                  Image(systemName: "arrow.left")
              }
              Spacer()
              KFImage(URL(string: "https://amatorkamp.pl/wp-content/uploads/2022/03/logo@2x-260x300.png"))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 45, height: 45)
              Spacer()
              Button(action: {
                  sharePostOnMessenger()
              }) {
                  Image(systemName: "square.and.arrow.up")
              }
          }
          .padding([.leading, .trailing], 15)
          .padding(.bottom, 7)
          .padding(.top, 10)
      }
      .background(Color(red: 1/255, green: 47/255, blue: 24/255))
  }
    
    func sharePostOnMessenger() {
        // Stwórz link do postu
        let postURL = URL(string: "https://amatorkamp.pl/\(share_url)")!

        // Przygotuj dane do udostępnienia
        let items: [Any] = [postURL]

        // Inicjuj kontroler udostępniania
        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)

        // Prezentuj kontroler udostępniania na ekranie
        UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
    }
}

struct NavBarNews_Previews: PreviewProvider {
  static var previews: some View {
      NavBarNews(share_url: "")
  }
}
