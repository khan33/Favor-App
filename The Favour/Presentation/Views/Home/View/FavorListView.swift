//
//  FavorListView.swift
//  The Favour
//
//  Created by Atta khan on 05/05/2023.
//

import SwiftUI

struct FavorListView: View {
    let image: String
    let name: String
    let favTitle: String
    let rating: String
    let totalReview: String
    var body: some View {
        HStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 88, height: 88)
                .padding([.leading, .vertical])
            VStack(alignment: .leading, spacing: 4) {
                FavorText(text: name, textColor: Color(#colorLiteral(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)), fontType: .bold, fontSize: 16, alignment: .center, lineSpace: 0)
                FavorText(text: favTitle, textColor: Color(#colorLiteral(red: 0.62, green: 0.62, blue: 0.62, alpha: 1)), fontType: .regular, fontSize: 10, alignment: .center, lineSpace: 0)
                    .padding(.bottom, 8)
                HStack {
                    
                    Image("Star")
                    
                    FavorText(text: rating, textColor: Color(#colorLiteral(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)), fontType: .medium, fontSize: 14, alignment: .leading, lineSpace: 0)
                    FavorText(text: "|  \(totalReview)", textColor: Color(#colorLiteral(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)), fontType: .medium, fontSize: 14, alignment: .leading, lineSpace: 0)
                }
                
            }
            .padding(.leading, 12)
            Spacer()
        }
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 32)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
        )
    }
}

struct FavorListView_Previews: PreviewProvider {
    static var previews: some View {
        FavorListView(image: "fav_cleaning", name: "Kylee Danford", favTitle: "House Cleaning", rating: "4.8", totalReview: "8.889 reviews")
    }
}
