//
//  DoFavorView.swift
//  The Favour
//
//  Created by Atta khan on 16/05/2023.
//

import SwiftUI

struct DoFavorView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            ZStack {
                RoundedRectangle(cornerRadius: 32)
                    .foregroundColor(.appWhite)
                VStack (alignment: .leading, spacing: 20) {
                    //I can do a car wash at you...
                    
                    HStack (alignment: .center, spacing: 0) {
                        FavorText(text: "I can do a car wash at your door step.", textColor: Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)), fontType: .bold, fontSize: 18, alignment: .center, lineSpace: 0)
                        Spacer()
                        Image("more")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16, height: 16)
                    }
                    
                    HStack (alignment: .center, spacing: 0) {
                        FavorButton(text: "Cleaning", width: 68, height: 24, textColor: .appPrimaryColor, fontType: .regular, fontSize: 10,  bgColor: Color(red: 0.945, green: 0.906, blue: 1)) {
                        }
                        Spacer()
                        ZStack(alignment: .center) {
                            Circle()
                                .fill(Color.appTitleColor)
                                .frame(width: 24, height: 24)
                                .overlay(
                                    FavorText(text: "05", textColor: .appWhite, fontType: .bold, fontSize: 11)
                                        .minimumScaleFactor(0.5)
                                    )
                            
                        }
                    }
                    
                    HStack (alignment: .center, spacing: 0) {
                        HStack {
                            
                            Image("Star")
                            
                            FavorText(text: "4.8", textColor: Color(#colorLiteral(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)), fontType: .medium, fontSize: 14, alignment: .leading, lineSpace: 0)
                            FavorText(text: "| 8.889 reviews", textColor: Color(#colorLiteral(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)), fontType: .medium, fontSize: 14, alignment: .leading, lineSpace: 0)
                        }
                        Spacer()
                        //Posted 2 min ago
                        FavorText(text: "Posted 2 min ago", textColor: Color(#colorLiteral(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)), fontType: .medium, fontSize: 12, alignment: .leading, lineSpace: 0)

                        
                        
                    }
                    
                    Spacer()
                }
                .padding(20)
                
            }
            .frame(width: .infinity, height: 160)
            
        }    }
}

struct DoFavorView_Previews: PreviewProvider {
    static var previews: some View {
        DoFavorView()
    }
}
