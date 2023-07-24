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

    var body: some View {
        
        VStack(alignment: .leading, spacing: 12) {
            
            NavigationBarView(text: "Post a favor")
                .padding(.bottom, 24)
            ScrollView {
                
//                ZStack {
//                    RoundedRectangle(cornerRadius: 12)
//                        .foregroundColor(.appTextFieldColor)
//                        .border(.appWhite, width: 1, cornerRadius: 12)
//                    HStack {
//
//                        TextFieldWithInputView(data: viewModel.services, placeholder: "Select Service", selectedData: $viewModel.selectedService)
//
//
//                            .foregroundColor(.appBlack)
//                            .font(.localizedFont(fontType: .regular, fontSize: 14))
//                        Image("down")
//                    }
//                    .padding(.horizontal)
//                }
//                .frame(height: 60)
                
                
                
                
                
                VStack(alignment: .leading) {
                    
                    FavorTextField(placeholder: "Select Service", leftImage: nil, rightImage: "down", text: $viewModel.service) {
                        showPicker = true
                    }
                    if showPicker {
                        Picker(selection: $viewModel.service, label: Text("")) {
                            ForEach(viewModel.serviceName, id: \.self) { country in
                                Text(country).tag(country)
                            }
                        }
                        .pickerStyle(InlinePickerStyle())
                        .focused($isPickerFocused) // Bind picker's focus to the focus state
                        .onChange(of: viewModel.service) { _ in
                            showPicker = false // Dismiss the picker after selection
                        }
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
                        viewModel.postFavor(image)
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
            viewModel.getService()
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
struct TextFieldWithInputView : UIViewRepresentable {
    var data : [ServiceModelData]?
    var placeholder : String

    @Binding var selectedData : ServiceModelData?

    private let textField = UITextField()
    private let picker = UIPickerView()
    

    func makeCoordinator() -> TextFieldWithInputView.Coordinator {
        Coordinator(textfield: self)
    }

    func makeUIView(context: UIViewRepresentableContext<TextFieldWithInputView>) -> UITextField {
        picker.delegate = context.coordinator
        picker.dataSource = context.coordinator
        picker.backgroundColor = .gray
        picker.tintColor = .black
        textField.placeholder = placeholder
        textField.inputView = picker
        textField.delegate = context.coordinator
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<TextFieldWithInputView>) {
       // uiView.text = selectedText
    }

    class Coordinator: NSObject, UIPickerViewDataSource, UIPickerViewDelegate , UITextFieldDelegate {

        private let parent : TextFieldWithInputView

        init(textfield : TextFieldWithInputView) {
            self.parent = textfield
        }

        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return self.parent.data?.count ?? 0
        }
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return self.parent.data?[row].name
        }
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//            self.parent.$selectionIndex.wrappedValue = row
            self.parent.selectedData = self.parent.data?[row]
            self.parent.textField.endEditing(true)

        }
        func textFieldDidEndEditing(_ textField: UITextField) {
            self.parent.textField.resignFirstResponder()
        }
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
