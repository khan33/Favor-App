//
//  ChatView.swift
//  The Favour
//
//  Created by Atta khan on 22/05/2023.
//

import SwiftUI

struct ChatView: View {
    @State private var messages: [(message: String, isSender: Bool)] = []
    @State private var newMessage: String = ""
    
    var body: some View {
        VStack {
            Text("Chat Feature is under development phase...")
                .frame(maxWidth: .infinity, alignment: .center)
                .frame(maxHeight: .infinity, alignment: .center)
//            List {
//                ForEach(messages.indices, id: \.self) { index in
//                    MessageBubbleView(message: messages[index].message, isSender: messages[index].isSender)
//                        .padding([.top, .bottom,])
//                }
//                .padding()
//            }
//            
//            HStack {
//                TextField("Enter your message", text: $newMessage)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                
//                Button(action: sendMessage) {
//                    Text("Send")
//                }
//                .padding(.leading, 8)
//            }
//            .padding()
        }
        .onAppear {
            messages.append((message: "How are you today", isSender: false))
            
            messages.append((message: "I am good what about you", isSender: true))
            
            messages.append((message: "Today we will meet at 8:00 PM, are you free so we will connect at that time", isSender: true))

            
            messages.append((message: "hi! how are you doing todayhi! how are you doing today hi! how are you doing today hi! how are you doing today", isSender: true))

        }
    }
    
    func sendMessage() {
        guard !newMessage.isEmpty else {
            return
        }
        
        messages.append((message: newMessage, isSender: false))
        newMessage = ""
    }
}


struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
