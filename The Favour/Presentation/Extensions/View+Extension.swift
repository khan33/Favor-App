//
//  View+Extension.swift
//  The Favour
//
//  Created by Atta khan on 16/04/2023.
//

import SwiftUI

extension View {
    func border(_ color: Color, width: CGFloat, cornerRadius: CGFloat) -> some View {
        overlay(RoundedRectangle(cornerRadius: cornerRadius).stroke(color, lineWidth: width))
    }
    func spinner(isShowing: Binding<Bool>) -> some View {
        self.modifier( FavorSpinnerView(isShowing: isShowing) )
    }

}
