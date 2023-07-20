//
//  HomeView.swift
//  The Favour
//
//  Created by Atta khan on 08/05/2023.
//

import SwiftUI
import HalfASheet

struct HomeView: View {
    @State private var searchText = ""
    @State private var isSheetShown = false
    @State var cardDismissal = false
    @State private var isServices = false
    
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    @State private var popularFavor = false
    @State private var favorDetail = false
    @State private var favorByService = false
    @State private var selectedIndex: Int = 0
    @State private var selectedService: ServiceModelData?
    @State private var favor_detail: FavorList?
    @StateObject var viewModel: FavorViewModel = FavorViewModel()

    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    
                    NavigationLink(destination: AllServicesView(), isActive: $isServices) { EmptyView() }
                    NavigationLink(destination: PopularServicesView(), isActive: $popularFavor) { EmptyView() }
                    if let service = selectedService {
                        NavigationLink(destination: FavorByService(service: service), isActive: $favorByService) { EmptyView() }
                    }
                    if let detail = favor_detail {
                        NavigationLink(destination: FavorDetailView(favor_detail: detail), isActive: $favorDetail) { EmptyView() }
                    }
                    
                    
                    CustomNavigationBarView()
                    SearchBarView(searchText: $searchText) {
                        isSheetShown = true
                    }
                    ScrollView(.vertical, showsIndicators: false) {
                        SeeAllView(label1: "Services", label2: "See All") {
                            isServices = true
                        }
                        .padding(.top, 12)
                        HomeServicesView
                        
                        Divider()
                            .padding(.vertical, 24)
                        SeeAllView(label1: "Most Popular Services", label2: "See All") {
                            popularFavor.toggle()
                        }
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                if let result = viewModel.popularServices {
                                    ForEach(result.indices, id: \.self) { index in
                                        ServiceButtonView(text: result[index].name, textColor: index == selectedIndex ? .appWhite : .appPrimaryColor , bgColor: index == selectedIndex ? .appPrimaryColor : .appWhite) {
                                            selectedIndex = index
                                            viewModel.filterFavorbyService(service_id: result[index].id ?? 0)
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.vertical,  20)
                        
                        
                        if let favor = viewModel.popularServicFavors {
                            if favor.isEmpty {
                                FavorText(text: "No favor available right now!", textColor: .red, fontType: .regular, fontSize: 9, alignment: .center, lineSpace: 0)
                                    .padding(.horizontal, 8)
                            } else {
                                ForEach(favor.indices.prefix(6), id: \.self) { index in
                                    FavorListView(image: favor[index].media?[0].media_url ?? "", name: favor[index].category ?? "Cleaning", favTitle: favor[index].title ?? "", rating: "4.8", totalReview: "8.889 reviews") {
                                        favor_detail = favor[index]
                                        favorDetail.toggle()
                                    }
                                }
                            }
                            
                            
                            
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 24)
                .background(Color.init(hex: "#FAFAFA"))
                .navigationBarHidden(true)
                .navigationTitle("")
                .spinner(isShowing: $viewModel.shouldShowLoader)
                
                //FilterModalView(isShowing: $isSheetShown, services: $service_titles)
            }
        }
        .onAppear {
            viewModel.getFavor()
        }
    }
    
    
    private var HomeServicesView: some View {
        LazyVGrid(columns: gridItemLayout, spacing: 20) {
            if let result = viewModel.services {
                ForEach(result.indices.prefix(8), id: \.self) { index in
                    ServicesView(service: result[index]) {
                        selectedService = result[index]
                        favorByService.toggle()
                    }
                }
            }
        }
    }
    
    func bottomSheetContent() -> some View {
            // Bottom sheet content goes here
            Text("Hello, world!")
        }
}

struct FilterView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            FavorText(text: "Filter",
                      textColor: .appTitleBlack , fontType: .bold, fontSize: 24, alignment: .center, lineSpace: 0)
            
            FavorDividerView(width: .infinity, height: 1)
            
            DistanceSliderView(minValue: 0, maxValue: 100, step: 1, title: "Location")
            
            FavorText(text: "Category",
                      textColor: .appTitleBlack , fontType: .bold, fontSize: 20, alignment: .center, lineSpace: 0)
            
            
            FavorText(text: "Favor Type",
                      textColor: .appTitleBlack , fontType: .bold, fontSize: 20, alignment: .center, lineSpace: 0)
            
            HStack {
                FavorButton(text: "Part Time", width: .infinity, height: 44, textColor: .appPrimaryColor, bgColor: Color(red: 0.945, green: 0.906, blue: 1)) {
                }
                FavorButton(text: "Full Time", width: .infinity, height: 44, bgColor: .appPrimaryColor) {
                    
                }
                
            }
            
            FavorDividerView(width: .infinity, height: 1)
            
            HStack {
                FavorButton(text: "Rest", width: .infinity, height: 60, textColor: .appPrimaryColor, bgColor: Color(red: 0.945, green: 0.906, blue: 1)) {
                }
                FavorButton(text: "Filter", width: .infinity, height: 60, bgColor: .appPrimaryColor) {
                    
                }
                
            }
            
            Spacer()
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}



struct BottomCard<Content: View>: View {
    @Binding  var isSheetShown: Bool
    @Binding var cardDismissal: Bool
    let height: CGFloat
    let content: Content

    
    init(isSheetShown: Binding<Bool>, cardDismissal: Binding<Bool>,
         height: CGFloat, @ViewBuilder content: () -> Content) {
        _isSheetShown = isSheetShown
        _cardDismissal = cardDismissal
        self.height = height
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            //  Dimmed
            GeometryReader { _ in
                EmptyView()
            }
            .background(Color.red.opacity(0.5))
            .opacity(isSheetShown ? 1 : 0)
            .animation(.easeIn)
            .onTapGesture {
                cardDismissal.toggle()
                isSheetShown.toggle()
            }
            
            // Card
            
            VStack {
                Spacer()
                VStack {
                    content
                }
                .background(Color.white)
                .frame(height: 300)
                .offset(y: isSheetShown ? 0 : 300)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
    
}
