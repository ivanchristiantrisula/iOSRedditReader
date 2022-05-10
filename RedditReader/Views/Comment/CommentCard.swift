//
//  CommentCard.swift
//  RedditReader
//
//  Created by Ivan Christian on 05/05/22.
//

import SwiftUI
import MarkdownUI

struct CommentCard: View {
    let comment : Comment
    let depth : Int
    let borderColor : [Color] = [.red, .green, .blue, .orange, .purple]
    
    
    @State var showProfile = false
    @State var isCollapsed = false
    
    var body: some View {
        ZStack{
            VStack(spacing : 12){
                //TOP
                HStack{
                    Text(comment.author ?? "")
                        .foregroundColor(authorColor(comment))
                    Image(systemName: "arrow.up")
                        .font(.headline)
                    Text(String(comment.score ?? 0 ))
                        .font(.subheadline)
                    Spacer()
                    Text("9h")
                        .font(.subheadline)
                }
                .onTapGesture {
                    print("masokkkk")
                }
                
                if(!isCollapsed){
                    try! Markdown(Document(markdown: comment.body!))
                }
                
            }
            .padding()
            .background(.regularMaterial).cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10).fill(borderColor[depth%borderColor.count]).mask(    // << here !!
                HStack {
                    Rectangle().frame(width: 5)
                    Spacer()
                }
            ).allowsHitTesting(false)  ) // << make click-through
            
            ZStack{
                NavigationLink("", destination: ProfileView(profileViewModel: ProfileViewModel(comment.author!)), isActive: $showProfile).hidden()
            }.frame(width: 0, height: 0)
        }
        .padding(.leading, CGFloat(depth)*10)
        .swipeActions(allowsFullSwipe: false) {
            Button {
                withAnimation {
                    showProfile.toggle()
                }
                
            } label: {
                Label("Profile", systemImage: "person.fill")
            }
            .tint(.indigo)

            Button {
                isCollapsed.toggle()
            } label: {
                Label(isCollapsed ? "Expand" : "Collapse", systemImage: isCollapsed ? "eye.fill" : "eye.slash.fill")
            }.tint(.yellow)
        }
        
        
    }
}

func authorColor(_ comment : Comment) -> Color{
    let distinct = comment.distinguished
    
    switch distinct {
    case "moderator" :
        return .green
        
    default :
        return .primary
    }
}

struct CommentCard_Previews: PreviewProvider {
    static var previews: some View {
        CommentCard(comment: Comment(id: "id1", name: "t1_i795a2u", body: "Lorem ipsun sit dolor met Lorem ipsun sit dolor met Lorem ipsun sit dolor met Lorem ipsun sit dolor met Lorem ipsun sit dolor met Lorem ipsun sit dolor met Lorem ipsun sit dolor met Lorem ipsun sit dolor met Lorem ipsun sit dolor met", isSubmitter: false, author: "I_Am_Author", lindId: nil, parentId: nil, created: Date(timeIntervalSince1970: 1651638429.0), createdUtc: Date(timeIntervalSince1970: 1651638429.0), replies: nil, score : 110, permalink: nil, authorFlairText: nil, authorFlairTextColor: nil, authorFlairBackgroundColor: nil), depth : 7)
    }
}
