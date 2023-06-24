//
//  SignupView1.swift
//  The Favour
//
//  Created by Atta khan on 26/04/2023.
//

import SwiftUI

struct SignupView1: View {
    
    @State var fullName: String = ""
    @State var nickName: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var dateOfBirth: String = ""
    @State var address: String = ""
    @State var phoneNumber: String = ""

    @State private var isNext = false
    @State private var birthDate = Date()
    @State private var textEditorText:String = "Write down your thoughts"
    @State var calendarId: UUID = UUID()

    @State var show: Bool = false
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            NavigationLink(destination: SignupAddPhoto(), isActive: $isNext) { EmptyView() }
            NavigationBarView(text: "Fill Your Profile")
            
            
            ScrollView(.vertical, showsIndicators: false) {
                FavorTextField(placeholder: "Full Name", leftImage: nil, rightImage: nil, text: $fullName)
                    .padding(.top, 24)
                
                FavorTextField(placeholder: "Email", leftImage: nil, rightImage: "email", text: $email)
                
                FavorTextField(placeholder: "Password", leftImage: nil, rightImage: "Lock", text: $nickName)
                
                
                
                FavorTextField(placeholder: "Date of Birth", leftImage: nil, rightImage: "calander", text: $dateOfBirth) {
                    withAnimation {
                        show.toggle()
                    }
                }
                
                
                FavorTextField(placeholder: "Phone Number", leftImage: nil, rightImage: nil, text: $phoneNumber)
                
                FavorTextField(placeholder: "Address", leftImage: nil, rightImage: "location", text: $address)
                
                
                FavorButton(text: "Continue", width: .infinity, height: 60, bgColor: .appPrimaryColor) {
                    isNext = true
                }
                .padding(.top, 24)
                Spacer()
            }
        }
        .padding()
        .navigationBarHidden(true)
        .navigationTitle("")
        .toolBarPopover(show: $show) {
            DatePicker("", selection: .constant(Date()), displayedComponents: [.date])
                .datePickerStyle(.graphical)
                .labelsHidden()
                .id(calendarId)
                .onChange(of: dateOfBirth) { _ in
                    calendarId = UUID()
                }
                .onTapGesture {
                    show.toggle()

                }
        }
    }
    
    
    var dateFormatter: DateFormatter {
           let formatter = DateFormatter()
           formatter.dateStyle = .long
           return formatter
       }
   
}

struct SignupView1_Previews: PreviewProvider {
    static var previews: some View {
        SignupView1()
    }
}
