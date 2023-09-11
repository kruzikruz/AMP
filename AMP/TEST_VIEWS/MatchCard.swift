//
//  MatchCard.swift
//  AMP
//
//  Created by Kornel Krużewski on 10/09/2023.
//

import SwiftUI
import Kingfisher

struct MatchCard: View {
    
    var TEAM1: String
    var TEAM2: String
    var TIME: String
    var TEAM1_BADGE: String
    var TEAM2_BADGE: String
    
    var body: some View {
        HStack(spacing: 8) {
            VStack(spacing: 14) {
                HStack{
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color(red: 0.21, green: 0.21, blue: 0.21))
                            .frame(width: 15, height: 15)
                        if let url = URL(string: TEAM1_BADGE) {
                            KFImage(url)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 15, height: 15)
                                .clipped()
                        } else {
                            Image("defaultbadge")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 15, height: 15)
                                .clipped()
                        }
                    }
                    .frame(width: 15, height: 15)
                    Text(TEAM1)
                      .font(
                        Font.custom("Inter", size: 9)
                          .weight(.medium)
                      )
                      .foregroundColor(.white)
                      .frame(width: 152, alignment: .topLeading)
                }
                HStack{
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color(red: 0.21, green: 0.21, blue: 0.21))
                            .frame(width: 15, height: 15)
                        if let url = URL(string: TEAM2_BADGE) {
                            KFImage(url)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 15, height: 15)
                                .clipped()
                        } else {
                            Image("defaultbadge")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 15, height: 15)
                                .clipped()
                        }

                    }
                    .frame(width: 15, height: 15)
                    Text(TEAM2)
                      .font(
                        Font.custom("Inter", size: 9)
                          .weight(.medium)
                      )
                      .foregroundColor(.white)
                      .frame(width: 152, alignment: .topLeading)
                }
            }
            .padding(.horizontal, 14)
            Spacer()
            //Wynik i FCM
            VStack(alignment: .center, spacing: 10) {
                HStack(alignment: .center, spacing: 20) {
                    Text(TIME)
                      .font(
                        Font.custom("Inter", size: 12)
                          .weight(.medium)
                      )
                      .foregroundColor(Color(red: 0.92, green: 0.92, blue: 0.92))
                    ZStack {
                        Image("Ellipse")
                            .frame(width: 15, height: 15)
                        Image("Ring")
                            .frame(width: 15, height: 15)
                    }
                    .frame(width: 24, height: 24)
                }
                .padding(0)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .frame(width: 115, alignment: .center)
            .background(Color(red: 0.24, green: 0.24, blue: 0.24))
            .cornerRadius(34)
        }
        .padding(.vertical, 8)
        .padding(.trailing, 5)
        .frame(width: 358, alignment: .leading)
        .background(Color(red: 0.21, green: 0.21, blue: 0.21))
        .cornerRadius(5)
    }
}

struct MatchCard_Previews: PreviewProvider {
    static var previews: some View {
        MatchCard(TEAM1: "TEAM1", TEAM2: "TEAM2", TIME: "00:00", TEAM1_BADGE: EMPTY_IMAGE_URL, TEAM2_BADGE: EMPTY_IMAGE_URL)
    }
}

