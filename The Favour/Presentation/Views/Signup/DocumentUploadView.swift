//
//  DocumentUploadView.swift
//  The Favour
//
//  Created by Atta khan on 26/04/2023.
//

import SwiftUI

struct DocumentUploadView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var isNext = false
    @State private var showModally = false
    var body: some View {
        ZStack {
            VStack (spacing: 16){
                //            NavigationLink(destination: AddPaymentMethods(), isActive: $isNext) { EmptyView() }
                
                FavorText(text: "Steps 2 of 2", textColor: .appTitleColor, fontType: .bold, fontSize: 20, alignment: .center, lineSpace: 0)
                    .padding(.vertical, 18)
                
                FavorText(text: "Upload a jpg, png or pdf, max size 1mb", textColor: Color(#colorLiteral(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)), fontType: .medium, fontSize: 18, alignment: .center, lineSpace: 0)
                    .padding(.bottom, 18)
                
                DocumentUploadButton(title: "Upload Id Front")
                
                DocumentUploadButton(title: "Upload Id Back")
                
                
                FavorButton(text: "Continue", width: .infinity, height: 60, bgColor: .appPrimaryColor) {
                    showModally = true
                    
                }
                Spacer()
            }
            .padding()
            
            CongratulationView(show: $showModally)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
        .navigationTitle("Fill Your Profile")
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

struct DocumentUploadView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentUploadView()
    }
}
