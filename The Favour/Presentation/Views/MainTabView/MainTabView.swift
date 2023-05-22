//
//  MainTabView.swift
//  The Favour
//
//  Created by Atta khan on 22/05/2023.
//

import SwiftUI

struct MainTabView: View {
    @State private var selection = 0
    @State var showingDetail = false

    @State private var home = UUID()
    @State private var share = UUID()
    @State private var dashboard = UUID()
    @State private var help = UUID()
    @State private var profile = UUID()
    @State private var tappedTwice: Bool = false
    
    var handler: Binding<Int> { Binding(
        get: { self.selection },
        set: {
           if $0 == self.selection {
               tappedTwice = true
           }
           self.selection = $0
       }
   )}
    
    var body: some View {
            TabView(selection: handler) {
                
                HomeView()
                    .onChange(of: tappedTwice, perform: { newValue in
                        guard newValue else { return }
                        home = UUID()
                        tappedTwice = false
                    })
                    .tabItem {
                        CustomTabItemView(imageName: "house.fill", title: "Home", isSelected: selection == 0)
                    }
                    .id(home)
                    .tag(0)
                
                
                
                
                
                    NeedFavorView()
                        .onChange(of: tappedTwice, perform: { newValue in
                            guard newValue else { return }
                            share = UUID()
                            tappedTwice = false
                        })
                        .tabItem {
                            CustomTabItemView(imageName: "suit.heart", title: "Favors", isSelected: selection == 1)

                        }
                        .id(share)
                        .tag(1)
                
                
                
                
                ProfileView()
                        .onChange(of: tappedTwice, perform: { newValue in
                            guard newValue else { return }
                            dashboard = UUID()
                            tappedTwice = false
                        })
                        .tabItem {
                            CustomTabItemView(imageName: "person", title: "Profile", isSelected: selection == 1)
                        }
                        .id(dashboard)
                        .tag(3)
               
                ChatView()
                    .onChange(of: tappedTwice, perform: { newValue in
                        guard newValue else { return }
                        help = UUID()
                        tappedTwice = false
                    })
                    .tabItem {
                        CustomTabItemView(imageName: "ellipsis.message", title: "Inbox", isSelected: selection == 1)

                    }
                    .id(help)
                    .tag(4)
                
            }
            .accentColor(.appTitleColor)
            .navigationBarTitle("")
            .navigationBarHidden(true)
//            .onAppear {
//                UITabBar.appearance().unselectedItemTintColor = UIColor(Color.appLightGrey)
//                UITabBar.appearance().backgroundColor = UIColor(Color.appLightGrey)
//            }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}


struct CustomTabItemView: View {
    let imageName: String
    let title: String
    let isSelected: Bool
    
    var body: some View {
        VStack {
            Image(systemName: imageName)
            Text(title)
        }
    }
}
