//
//  TeamView.swift
//  AMP
//
//  Created by Kornel Krużewski on 09/09/2023.
//

import SwiftUI

struct TeamView: View {
    
    let table: Table
    var selectedRowID: String
    var selectedDatum: Datum?
        
    var body: some View {
        VStack {
            Text("TeamView")
                .font(.largeTitle)
                .bold()
        }
    }
}

struct TeamView_Previews: PreviewProvider {
    static var previews: some View {
        TeamView(table: Table.default, selectedRowID: .init())
    }
}
