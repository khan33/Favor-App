//
//  MainView.swift
//  The Favour
//
//  Created by Atta khan on 16/04/2023.
//

import SwiftUI


enum FavorType: String{
    case needFavor = "favor_buyer" //"Need a favor"
    case canDoFavor = "favor_seller" //"can do you a favor"
}

struct MainView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var isMainView = false
    @StateObject var viewModel: AthenticationViewModel = AthenticationViewModel()

    var body: some View {
        VStack(spacing: 12) {
            NavigationLink(destination: SignupView1(), isActive: $isMainView) { EmptyView() }
            NavigationBarView(text: "Select Favor Type")
                .padding()

            //Elements/Promo & Discount
            FavorCardView(title: "I NEED A FAVOR", subTitle: "Get you work done in a quick way. We are here for your help.", imageName: "Group 253", gradientColor: Gradient(stops: [
                .init(color: Color(#colorLiteral(red: 0.6509804129600525, green: 0.3176470696926117, blue: 0.8196078538894653, alpha: 1)), location: 0),
                .init(color: Color(#colorLiteral(red: 0.6165271997451782, green: 0.3500000238418579, blue: 1, alpha: 1)), location: 1)])) {
                    
//                    if PrefsManager.shared.favorType == "" {
//                        let user = User(id: nil, first_name: nil, last_name: nil, contact_number: nil, email: nil, name: nil, user_type: nil, address: nil, dob: nil, id_card: nil, user_types: nil, user_selected_type: FavorType.needFavor.rawValue, lat: nil, lng: nil, profile_photo: nil, user_status: nil, file_back_url: nil, file_front_url: nil, file_type: nil, login_type: nil, token: nil)
//                        viewModel.updateProfile(user)
//                    } else {
                        isMainView = true

                        PrefsManager.shared.favorType = FavorType.needFavor.rawValue
//                    }
                }
                .padding(.top, 24)
            
            
            FavorCardView(title: "I CAN DO YOU A FAVOR", subTitle: "Get discount for every order, only valid for today", imageName: "do_favor", gradientColor: Gradient(stops: [
                .init(color: Color(#colorLiteral(red: 0.13333334028720856, green: 0.7333333492279053, blue: 0.6117647290229797, alpha: 1)), location: 0),
                .init(color: Color(#colorLiteral(red: 0.20682293176651, green: 0.8708333373069763, blue: 0.7362953424453735, alpha: 1)), location: 1)])) {
                    if PrefsManager.shared.favorType == "" {
                        let user = User(id: nil, first_name: nil, last_name: nil, contact_number: nil, email: nil, name: nil, user_type: nil, address: nil, dob: nil, id_card: nil, user_types: nil, user_selected_type: FavorType.needFavor.rawValue, lat: nil, lng: nil, profile_photo: nil, user_status: nil, file_back_url: nil, file_front_url: nil, file_type: nil, login_type: nil, token: nil)
                        viewModel.updateProfile(user)
                    } else {
                        isMainView = true
                        PrefsManager.shared.favorType = FavorType.canDoFavor.rawValue
                    }
                }
            
            Spacer()
        }
        
        .background(Color.white)
        .navigationBarBackButtonHidden(true)
//        .navigationBarItems(leading: btnBack)
//        .navigationTitle("Select Favor Type")

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
