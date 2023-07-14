//
//  FavorCardView.swift
//  The Favour
//
//  Created by Atta khan on 26/04/2023.
//

import SwiftUI

struct FavorCardView: View {
    let title: String
    let subTitle: String
    let imageName: String
    let gradientColor: Gradient
    var action: (()-> Void)?
    var body: some View {
        //Elements/Promo & Discount
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(LinearGradient(
                    gradient: gradientColor,
                    startPoint: UnitPoint(x: 1.0000000298023233, y: 1.000000029802323),
                    endPoint: UnitPoint(x: 1.1102230246251565e-16, y: -4.440892098500626e-16)))
                .frame(width: 380, height: 210)
                .shadow(color: Color(#colorLiteral(red: 0.01568627543747425, green: 0.0235294122248888, blue: 0.05882352963089943, alpha: 0.05000000074505806)), radius:60, x:0, y:4)
            
            
            
            Image("fav_bg_1")
                .resizable()
                .scaledToFit()
            
            HStack(alignment: .top) {
                VStack (alignment: .leading, spacing: 8) {
                    FavorText(text: title, textColor: .appWhite, fontType: .bold, fontSize: 28)

                    FavorText(text: subTitle, textColor: .appWhite, fontType: .regular, fontSize: 14)
                }
                .padding(.top, 20)
                .padding(.leading, 20)
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 188, height: 230)
            }
        }
        .onTapGesture {
            action?()
        }
    }
}

struct FavorCardView_Previews: PreviewProvider {
    static var previews: some View {
        FavorCardView(title: "I NEED A FAVOR", subTitle: "Get you work done in a quick way. We are here for your help.", imageName: "do_favor", gradientColor: Gradient(stops: [
            .init(color: Color(#colorLiteral(red: 0.13333334028720856, green: 0.7333333492279053, blue: 0.6117647290229797, alpha: 1)), location: 0),
            .init(color: Color(#colorLiteral(red: 0.20682293176651, green: 0.8708333373069763, blue: 0.7362953424453735, alpha: 1)), location: 1)]))
    }
}
