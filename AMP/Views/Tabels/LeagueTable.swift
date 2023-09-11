//
//  LeagueTable.swift
//  AMP
//
//  Created by Kornel Krużewski on 09/09/2023.
//

import Foundation

import SwiftUI
import Kingfisher
import Combine


struct LeagueTable: View {
    
    @EnvironmentObject private var routerManager: NavigationRouter
    @EnvironmentObject var tableAPICall: TableAPICall
    @EnvironmentObject var teamsAPICall: TeamsAPICall
    @State private var isRefreshing = false

    var body: some View {
            NavigationStack(path: $routerManager.routes) {
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .center, spacing: 14) {
                            HStack {
                                Text("Tabela")
                                    .font(.custom("Poppins", size: 13))
                                    .kerning(0.23504)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                                
                                Spacer()
                                
                                Button(action: {
                                    // Akcja, która zostanie wykonana po kliknięciu przycisku
                                }) {
                                    Text("Zobacz całą tabele")
                                        .font(.custom("Poppins", size: 12))
                                        .kerning(0.26283)
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(Color(red: 0.82, green: 0.71, blue: 1))
                                }
                            }
                            .frame(width: 330, height: 31.5391)
                            .padding(.top, 10)
                            HStack {
                                Text("Drużyna")
                                    .font(.custom("Poppins", size: 10))
                                    .kerning(0.23504)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                                
                                Spacer()
                                Text("M")
                                    .font(.custom("Poppins", size: 10))
                                    .kerning(0.26283)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                                    .frame(width: 15)
                                Text("RB")
                                    .font(.custom("Poppins", size: 10))
                                    .kerning(0.26283)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                                    .frame(width: 20)
                                Text("Pkt")
                                    .font(.custom("Poppins", size: 10))
                                    .kerning(0.26283)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                                    .frame(width: 20)
                            }
                            .frame(width: 330, height: 10)
                            VStack{
                                ForEach(tableAPICall.table.filter { $0.id == 6514 }, id: \.id)  { table in
                                    
                                    let sortedData = table.data.sorted { (entry1, entry2) in
                                        if let pos1 = convertToInteger(entry1.value.pos), let pos2 = convertToInteger(entry2.value.pos) {
                                            return pos1 < pos2
                                        } else {
                                            return entry1.value.pos < entry2.value.pos
                                        }
                                    }
                                    
                                    ForEach(sortedData.filter { $0.value.pos != "Pozycja" }, id: \.key) { datum in
                                        HStack{
                                            Text(datum.value.pos)
                                                .font(.custom("Poppins", size: 12).weight(.medium))
                                                .multilineTextAlignment(.center)
                                                .foregroundColor(.white)
                                                .frame(width: 14)
                                            HStack {
                                                if !datum.key.isEmpty {
                                                    if let teamID = Int(datum.key),
                                                       let imageURL = teamsAPICall.getTeamImageURL(for: teamID) {
                                                        KFImage(URL(string: imageURL))
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fit)
                                                            .frame(width: 18, height: 18)
                                                    } else {
                                                        Image("defaultbadge")
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fit)
                                                            .frame(width: 18, height: 18)
                                                    }
                                                }
                                            }
                                            Text(datum.value.name)
                                                .font(.custom("Poppins", size: 12))
                                                .kerning(0.26283)
                                                .foregroundColor(.white)
                                            Spacer()
                                            Text(datum.value.p)
                                                .font(.custom("Poppins", size: 12).weight(.medium))
                                                .multilineTextAlignment(.center)
                                                .foregroundColor(.white)
                                                .frame(width: 15)
                                            Text(datum.value.gd)
                                                .font(.custom("Poppins", size: 12).weight(.medium))
                                                .multilineTextAlignment(.center)
                                                .foregroundColor(.white)
                                                .frame(width: 20)
                                            Text(datum.value.pts)
                                                .font(.custom("Poppins", size: 12).weight(.medium))
                                                .multilineTextAlignment(.center)
                                                .foregroundColor(.white)
                                                .frame(width: 20)
                                        }
                                        .frame(width: 330, height: 25)
                                    }
                                }
                            }
                        }
                    }
                    .onAppear {
                        print("Getting table data...")
                        tableAPICall.getTable()
                        print("Table data: \(tableAPICall.table)")
                        teamsAPICall.getTeams()
                        isRefreshing = true
                    }
                    .onReceive(Just(isRefreshing)) { refreshed in
                        if refreshed {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                isRefreshing = false
                            }
                        }
                    }
            }
    }
}



func convertToInteger(_ pos: String) -> Int? {
    if let intValue = Int(pos) {
        return intValue
    } else {
        return nil
    }
}

struct TableCellView: View {
    let text: String
    let width: CGFloat
    
    var body: some View {
        Text(text)
            .font(.custom("Source Sans Pro", size: 14))
            .foregroundColor(.white)
            .frame(width: width, alignment: .leading)
            .lineLimit(1)
    }
}

struct LeagueTable_Previews: PreviewProvider {
    static var previews: some View {
        LeagueTable()
            .environmentObject(NavigationRouter())
            .environmentObject(TableAPICall())
            .environmentObject(TeamsAPICall())
            .environmentObject(TableAPICall())
    }
}
