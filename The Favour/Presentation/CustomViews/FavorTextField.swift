//
//  FavorTextField.swift
//  The Favour
//
//  Created by Atta khan on 16/04/2023.
//

import SwiftUI

struct FavorTextField: View {
    let placeholder: String
    let leftImage: String?
    let rightImage: String?

    @Binding var text: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.appTextFieldColor)
                .frame(height: 60)
                .border(.appWhite, width: 1, cornerRadius: 12)
            HStack {
                if let left_image = leftImage {
                    Image(left_image)
                }
                TextField(placeholder, text: $text)
                    .foregroundColor(.appBlack)
                    .font(.localizedFont(fontType: .regular, fontSize: 14))
                if let right_image = rightImage {
                    Image(right_image)
                }
                
            }.padding(.horizontal)
                
        }
        
        
    }
}

struct FavorTextField_Previews: PreviewProvider {
    static var previews: some View {
        FavorTextField(placeholder: "Email", leftImage: nil, rightImage: "calander", text: .constant("abc@gmailcom"))
    }
}