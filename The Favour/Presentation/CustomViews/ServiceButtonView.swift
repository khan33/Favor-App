//
//  ServiceButtonView.swift
//  The Favour
//
//  Created by Atta khan on 05/05/2023.
//

import SwiftUI

struct ServiceButtonView: View {
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
            VStack(alignment: .center) {
                if let text = text {
                    Text(text)
                        .font(.localizedFont(fontType: fontType, fontSize: fontSize))
                        .foregroundColor(textColor)
                        .padding(8)
                }
            }
            .background(bgColor)
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(textColor, lineWidth: 1)
            )
        }
    }
}

struct ServiceButtonView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 10) {
//            ServiceButtonView(text: "All is well", textColor: .appPrimaryColor, bgColor: .white)
//
//            ServiceButtonView(text: "All is well Cleaning", textColor: .white, bgColor: .appPrimaryColor)
//            ServiceButtonView(text: "Repairing", textColor: .white, fontType: .regular, fontSize: 12,
//                              bgColor: .appPrimaryColor)
            
            ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(0..<20) { index in
                            ServiceButtonView(text: "All New", textColor: index == 0 ? .appWhite : .appPrimaryColor , bgColor: index == 0 ? .appPrimaryColor : .appWhite)
                            
                            //ServiceButtonView(text: "All is well Cleaning", textColor: .white, bgColor: .appPrimaryColor)
                        }
                    }
                }
                .frame(height: 150)
            

        }
    }
}
