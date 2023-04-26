//
//  DocumentUploadButton.swift
//  The Favour
//
//  Created by Atta khan on 26/04/2023.
//

import SwiftUI

struct DocumentUploadButton: View {
    let title: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
            .fill(Color(hex: "#F8F8F8"))
            .frame(width: .infinity, height: 144)
            .border(.appBorderColor, width: 1, cornerRadius: 16)
            
            VStack(alignment: .center, spacing: 12) {
                
                
                ZStack {
                        Circle()
                            .frame(width: 44, height: 44)
                            .foregroundColor(.appPrimaryColor)
                            .opacity(0.2)
                        Image(systemName: "plus")
                            .foregroundColor(.appPrimaryColor)
                            .frame(width: 44, height: 44)
                    }
                
                
                FavorText(text: title, textColor: Color(#colorLiteral(red: 0.46, green: 0.46, blue: 0.46, alpha: 1)), fontType: .semiBold, fontSize: 18).tracking(0.2)
                    
      
                
            }
        }
        .padding(.horizontal, 16)
    }
}

struct DocumentUploadButton_Previews: PreviewProvider {
    static var previews: some View {
        DocumentUploadButton(title: "Upload ID Front")
    }
}