//
//  DocumentUploadView.swift
//  The Favour
//
//  Created by Atta khan on 26/04/2023.
//

import SwiftUI

struct DocumentUploadView: View {
    var body: some View {
        VStack (spacing: 16){
            FavorText(text: "Steps 2 of 3", textColor: .appTitleColor, fontType: .bold, fontSize: 20, alignment: .center, lineSpace: 0)
                .padding(.horizontal, 8)
            
            FavorText(text: "Upload a jpg, png or pdf, max size 1mb", textColor: Color(#colorLiteral(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)), fontType: .medium, fontSize: 18, alignment: .center, lineSpace: 0)
                .tracking(0.2)
            
            DocumentUploadButton(title: "Upload Id Front")
            
            DocumentUploadButton(title: "Upload Id Back")
            
            
            FavorButton(text: "Continue", width: .infinity, height: 60, bgColor: .appPrimaryColor) {
            }
        }
    }
}

struct DocumentUploadView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentUploadView()
    }
}
