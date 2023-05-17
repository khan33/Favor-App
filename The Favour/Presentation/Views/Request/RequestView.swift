//
//  RequestView.swift
//  The Favour
//
//  Created by Atta khan on 16/05/2023.
//

import SwiftUI

struct RequestView: View {
    @State private var isExpandable = false
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            ZStack {
                RoundedRectangle(cornerRadius: 32)
                    .foregroundColor(.appWhite)
                    
                
                VStack (alignment: .leading) {
                    HStack (alignment: .top, spacing: 0) {
                        Image("fav_cleaning")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 56, height: 56)
                            .padding([.leading, .vertical])
                        
                        VStack(alignment: .leading, spacing: 4) {
                            FavorText(text: "Atta khan", textColor: .appBlack, fontType: .bold, fontSize: 16, alignment: .center, lineSpace: 0)
                                .padding(.bottom, 8)
                            HStack {
                                
                                Image("Star")
                                
                                FavorText(text: "4.8", textColor: Color(#colorLiteral(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)), fontType: .medium, fontSize: 14, alignment: .leading, lineSpace: 0)
                                FavorText(text: "| 8.889 reviews", textColor: Color(#colorLiteral(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)), fontType: .medium, fontSize: 14, alignment: .leading, lineSpace: 0)
                            }
                            
                        }
                        .padding(12)
                        Spacer()
                        ZStack {
                            Circle()
                                .fill(Color.appPrimaryColor)
                                .opacity(0.2)
                                .frame(width: 44, height: 44)
                            Image(systemName: "ellipsis.message.fill")
                                .foregroundColor(.appTitleColor)
                        }
                        .padding(.trailing, 24)
                    }
                    .onTapGesture {
                    }
                    .padding(.top, 24)
                    FavorText(text: "16 $", textColor: Color(#colorLiteral(red: 0.43, green: 0.23, blue: 0.73, alpha: 1)), fontType: .bold, fontSize: 24, alignment: .leading, lineSpace: 0)
                        .padding(.leading, 70)
                    
                    HStack {
                        FavorButton(text: "Accept", width: .infinity, height: 50, textColor: .appPrimaryColor, bgColor: .appWhite) {
                        }
                        .border(.appPrimaryColor, width: 0.5, cornerRadius: 24)
                        FavorButton(text: "Book Favor", width: .infinity, height: 50, textColor: Color.red, bgColor: .appWhite) {
                            
                        }
                        .border(Color.red, width: 0.5, cornerRadius: 24)

                    }
                    .padding(.horizontal, 24)
                    FavorDividerView(width: .infinity, height: 0.5)
                    if isExpandable { requestExpandInfoView }
                    
                    HStack {
                        Spacer()
                        upDownIcon
                            .onTapGesture {
                                isExpandable.toggle()
                            }
                        Spacer()
                    }
                    .padding(.vertical, 8)
                    
                    
                    Spacer()
                }
                
            }
            .frame(width: .infinity, height: isExpandable ? 420 : 300)
            
        }
    }
    private var upDownIcon: some View {
        Image(systemName: isExpandable ? "chevron.up" : "chevron.down")
            .resizable()
            .scaledToFit()
            .frame(width: 16, height: 16)
            .foregroundColor(isExpandable ? .appLightBlack : .appBlack)
    }
    
    private var requestExpandInfoView: some View {
        VStack(spacing: 16) {
            HorizontalTwoLabelView(label1: "Date & Time", label2: "Dec 12, 2024 | 13:00 - 15:00 PM", fontTypeLbl1: .medium, fontSizeLbl1: 14,  fontTypeLbl2: .semiBold, fontSizeLbl2: 16)
            HorizontalTwoLabelView(label1: "Location", label2: "1691 Carpenter Pass", fontTypeLbl1: .medium, fontSizeLbl1: 14, fontTypeLbl2: .semiBold, fontSizeLbl2: 16)
            HorizontalTwoLabelView(label1: "Distance", label2: "6 mile away", fontTypeLbl1: .medium, fontSizeLbl1: 14, fontTypeLbl2: .semiBold, fontSizeLbl2: 16)
        }
        .padding(.horizontal, 16)
    }
}

struct RequestView_Previews: PreviewProvider {
    static var previews: some View {
        RequestView()
    }
}
