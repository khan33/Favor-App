//
//  RatingStarButtonView.swift
//  The Favour
//
//  Created by Atta khan on 12/05/2023.
//

import SwiftUI

struct RatingStarButtonView: View {
    let text: String?
    var textColor: Color = .appWhite
    var fontType: DefaultFontFamily = .bold
    var fontSize: CGFloat = 14
    var bgColor: Color = .appPrimaryColor
    var cornerRadius: CGFloat = 20
    var action: (() -> Void)? = nil
    var body: some View {
        Button(action: {
            action?()
        }) {
            HStack(alignment: .center, spacing: 8) {
                Image(systemName: "star.fill")
                    .foregroundColor(bgColor == .white ? .appPrimaryColor : .white)
                    .frame(width: 16, height: 16)
                    .padding(.vertical, 11)
                    .padding(.leading, 20)
                
               
                if let text = text {
                    FavorText(text: text, textColor:  textColor, fontType: fontType, fontSize: fontSize, alignment: .leading, lineSpace: 0)
                        .padding(.trailing, 20)
                }
            }
            .frame(width: 83, height: 38)
            .background(bgColor)
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(textColor, lineWidth: 1)
            )
        }
    }
}

struct RatingStarButtonView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            RatingStarButtonView(text: "All", textColor: .appWhite, fontType: .semiBold, fontSize: 16, bgColor: .appPrimaryColor)
            RatingStarButtonView(text: "5", textColor: .appPrimaryColor, fontType: .semiBold, fontSize: 16, bgColor: .white)

        }
        
    }
}
