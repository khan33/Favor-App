//
//  DoFavorView.swift
//  The Favour
//
//  Created by Atta khan on 16/05/2023.
//

import SwiftUI

struct DoFavorView: View {
    var favor: FavorList?
    @State private var selectedItem: String?
    
    var body: some View {
        VStack (alignment: .leading, spacing: 20) {
            HStack {
                FavorText(text: favor?.title ?? "TI can do a car wash at your door step.", textColor: Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)), fontType: .bold, fontSize: 18, alignment: .leading, lineSpace: 0)
                    .lineLimit(2)
                Spacer()
                Image("more")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                    .contextMenu {
                        Button(action: {
                            // Perform delete action
                            deleteItem(selectedItem)
                        }) {
                            Label("Delete", systemImage: "trash")
                        }

                        Button(action: {
                            // Perform edit action
                            editItem(selectedItem)
                        }) {
                            Label("Edit", systemImage: "pencil")
                        }
                    }
                    
            }
            .padding(.top, 16)
            
            HStack {
                FavorButton(text: favor?.category ?? "", width: 68, height: 24, textColor: .appPrimaryColor, fontType: .regular, fontSize: 10,  bgColor: Color(red: 0.945, green: 0.906, blue: 1)) {
                }
                Spacer()
                ZStack(alignment: .center) {
                    Circle()
                        .fill(Color.appTitleColor)
                        .frame(width: 24, height: 24)
                        .overlay(
                            FavorText(text: "05", textColor: .appWhite, fontType: .bold, fontSize: 11)
                                .minimumScaleFactor(0.5)
                        )
                }
            }
            
            HStack {
                HStack {
                    Image("Star")
                    FavorText(text: "4.8", textColor: Color(#colorLiteral(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)), fontType: .medium, fontSize: 14, alignment: .leading, lineSpace: 0)
                    FavorText(text: "| 8.889 reviews", textColor: Color(#colorLiteral(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)), fontType: .medium, fontSize: 14, alignment: .leading, lineSpace: 0)
                }
                Spacer()
                //Posted 2 min ago
                FavorText(text: "Posted 2 min ago", textColor: Color(#colorLiteral(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)), fontType: .medium, fontSize: 12, alignment: .leading, lineSpace: 0)
            }
            .padding(.bottom, 16)

            
        }
        .padding(16)
        .background(Color(.white).cornerRadius(22))
    }
    
    func deleteItem(_ item: String?) {
        guard let item = item else { return }
        // Delete logic goes here
        print("Delete: \(item)")
    }

    func editItem(_ item: String?) {
        guard let item = item else { return }
        // Edit logic goes here
        print("Edit: \(item)")
        
        
    }
    
    
    
    
}

struct DoFavorView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 10) {
            DoFavorView()
            DoFavorView()
        }
        .padding(24)
        .background( Color(#colorLiteral(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)))

    }
}
