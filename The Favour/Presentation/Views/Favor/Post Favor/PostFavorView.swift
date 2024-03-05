//
//  PostFavorView.swift
//  The Favour
//
//  Created by Atta khan on 17/05/2023.
//

import SwiftUI

struct PostFavorView: View {
    
    @State private var selectedImage: UIImage? = nil
    @State private var showImagePicker: Bool = false

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @StateObject private var viewModel: FavorViewModel = FavorViewModel()
    @State private var showPicker = false
    @FocusState private var isPickerFocused: Bool
    @StateObject private var locationManager = LocationManager()

    var body: some View {
        
        VStack(alignment: .leading, spacing: 12) {
            
            NavigationBarView(text: "Post a favor")
                .padding(.bottom, 24)
            ScrollView {
                VStack(alignment: .leading) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(.appTextFieldColor)
                            .frame(height: 60)
                            .border(.appWhite, width: 1, cornerRadius: 12)
                        
                        HStack {
                            FavorText(text: viewModel.service == "" ? "Select Service" : viewModel.service, textColor: .appBlack, fontType: .regular, fontSize: 14, alignment: .leading, lineSpace: 0)
                                .padding()
                            Spacer()
                            Menu(content: {
                                if let services =  viewModel.services {
                                    ForEach(services) { item in
                                        Button(action: {
                                            viewModel.selectedService = item
                                            viewModel.service = item.name ?? ""
                                        }) {
                                            Text(item.name ?? "")
                                        }
                                    }
                                }
                                
                            }, label: {
                                Image("down")
                                    .resizable()
                                    .frame(maxWidth:12, maxHeight: 12)
                                
                            })
                            
                        }
                        .padding(.trailing, 12)

                    }
                    
                    
                    FavorTextField(placeholder: "Title", leftImage: nil, rightImage: nil, text: $viewModel.title)
                    FavorText(text: viewModel.titleError, textColor: .red, fontType: .regular, fontSize: 9, alignment: .center, lineSpace: 0)
                        .padding(.horizontal, 8)
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(.appTextFieldColor)
                        .frame(height: 100)
                        .border(.appWhite, width: 1, cornerRadius: 12)
                    TextViewWrapper(text: $viewModel.desc)
                        .padding(8)
                        .frame(height: 100)
                        .cornerRadius(8)
                }
                FavorText(text: viewModel.descError, textColor: .red, fontType: .regular, fontSize: 9, alignment: .center, lineSpace: 0)
                    .padding(.horizontal, 8)
                VStack(alignment: .leading) {
                    FavorTextField(placeholder: "Add Tags", leftImage: nil, rightImage: nil, text: $viewModel.tags)
                    FavorText(text: viewModel.tagsError, textColor: .red, fontType: .regular, fontSize: 9, alignment: .center, lineSpace: 0)
                        .padding(.horizontal, 8)
                }
                VStack {
                    FavorButton(text: "Upload Image", width: .infinity, height: 44, textColor: .appPrimaryColor, bgColor: Color(red: 0.945, green: 0.906, blue: 1)) {
                        showImagePicker = true
                    }
                    if showImagePicker == false {
                        FavorText(text: "* Require Image.", textColor: .red, fontType: .regular, fontSize: 9, alignment: .leading, lineSpace: 0)
                            .padding(.horizontal, 8)
                        
                    }
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                    }
                }
                FavorButton(text: "Post", width: .infinity, height: 60, bgColor: .appPrimaryColor) {
                    if let image = selectedImage {
                        if let location = locationManager.currentLocation {
                            //lat: "31.417947", lng: "74.257103"
                            viewModel.postFavor(image: image, lat: String(location.coordinate.latitude), lng: String(location.coordinate.longitude), address: locationManager.currentAddress)
                        }
                    }

                    //viewModel.postFavor()
                }
                .padding(.top, 24)
            }
        }
        .padding(24)
        .navigationBarHidden(true)
        .navigationTitle("")
        .spinner(isShowing: $viewModel.shouldShowLoader)
        .sheet(isPresented: $showImagePicker) {
            ImagePickerView(selectedImage: $selectedImage)
        }
        .onAppear {
            locationManager.startUpdatingLocation()
            viewModel.getService()
        }
        .onDisappear {
            locationManager.stopUpdatingLocation()
        }
        .alert(isPresented: $viewModel.isAlertShow, content: {
            Alert(title: Text("Alert"),
                  message: Text(viewModel.alertMsg),
                  dismissButton: .default(Text("OK"), action: {
                // Perform any action here if needed before dismissing the view
                presentationMode.wrappedValue.dismiss()
            }))
        })
    }
}

struct PostFavorView_Previews: PreviewProvider {
    static var previews: some View {
        PostFavorView()
    }
}
struct TextViewWrapper: UIViewRepresentable {
    @Binding var text: String
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.isScrollEnabled = true
        textView.isEditable = true
        textView.font = UIFont.preferredFont(forTextStyle: .footnote)
        
        textView.backgroundColor = .clear
        textView.text = "Description"
        textView.textColor = .lightGray
        textView.returnKeyType = .done
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
//        if text.isEmpty {
//            uiView.text = "Description"
//            uiView.textColor = .lightGray
//        } else {
//            uiView.text = text
//            uiView.textColor = .black
//        }
        
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: TextViewWrapper
        
        init(_ textViewWrapper: TextViewWrapper) {
            parent = textViewWrapper
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.text == "Description" {
                textView.text = ""
                textView.textColor = .black
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.isEmpty {
                //textView.text = "Description"
                textView.textColor = .lightGray
            }
        }

    }
}
struct ImagePickerView: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        @Binding var selectedImage: UIImage?
        
        init(selectedImage: Binding<UIImage?>) {
            _selectedImage = selectedImage
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                selectedImage = image
            }
            
            picker.dismiss(animated: true, completion: nil)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // No need to update
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(selectedImage: $selectedImage)
    }
}
