//
//  HorizontalTwoLabelView.swift
//  The Favour
//
//  Created by Atta khan on 28/04/2023.
//

import SwiftUI

struct HorizontalTwoLabelView: View {
    var label1: String = ""
    var label2: String = ""
    
    var body: some View {
        HStack {
            FavorText(text: label1, textColor: Color(#colorLiteral(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)), fontType: .regular, fontSize: 14, alignment: .center, lineSpace: 0)
            Spacer()
            FavorText(text: label2, textColor: Color(#colorLiteral(red: 0.26, green: 0.26, blue: 0.26, alpha: 1)), fontType: .semiBold, fontSize: 16, alignment: .center, lineSpace: 0)
        }
    }
}

struct HorizontalTwoLabelView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalTwoLabelView(label1: "Withdraw Amount", label2: "$50")
    }
}
