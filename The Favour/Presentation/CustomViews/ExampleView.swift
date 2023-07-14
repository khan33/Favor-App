//
//  ExampleView.swift
//  The Favour
//
//  Created by Atta khan on 09/07/2023.
//

import SwiftUI

struct ExampleView: View {
    let items = ["Item 1", "Item 2", "Item 3"]
    @State private var selectedItem: String?
    @State private var isMenuVisible = false

    var body: some View {
        VStack {
                    List(items, id: \.self) { item in
                        Text(item)
                            .onTapGesture {
                                selectedItem = item
                            }
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
                }
    }
    
    func placeOrder() { }
    func adjustOrder() { }
    func cancelOrder() { }

    func deleteItem(_ item: String?) {
        // Delete logic goes here
        print("Delete: \(item)")
    }
    
    func editItem(_ item: String?) {
        // Edit logic goes here
        print("Edit: \(item)")
    }
}

struct ExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView()
    }
}
