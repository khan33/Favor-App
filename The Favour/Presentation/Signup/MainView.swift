//
//  MainView.swift
//  The Favour
//
//  Created by Atta khan on 16/04/2023.
//

import SwiftUI

struct MainView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            //Elements/Promo & Discount
            FavorCardView(title: "I NEED A FAVOR", subTitle: "Get you work done in a quick way. We are here for your help.", imageName: "need_fav", gradientColor: Gradient(stops: [
                .init(color: Color(#colorLiteral(red: 0.6509804129600525, green: 0.3176470696926117, blue: 0.8196078538894653, alpha: 1)), location: 0),
                .init(color: Color(#colorLiteral(red: 0.6165271997451782, green: 0.3500000238418579, blue: 1, alpha: 1)), location: 1)]))
            
            
            FavorCardView(title: "I CAN DO YOU A FAVOR", subTitle: "Get discount for every order, only valid for today", imageName: "do_favor", gradientColor: Gradient(stops: [
                .init(color: Color(#colorLiteral(red: 0.13333334028720856, green: 0.7333333492279053, blue: 0.6117647290229797, alpha: 1)), location: 0),
                .init(color: Color(#colorLiteral(red: 0.20682293176651, green: 0.8708333373069763, blue: 0.7362953424453735, alpha: 1)), location: 1)]))
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
        .navigationTitle("Select Favor Type")

    }
    var btnBack : some View { Button(action: {
            self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                Image("ic_back") // set image here
                    .aspectRatio(contentMode: .fit)
                }
            }
        }

}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
