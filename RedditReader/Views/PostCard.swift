//
//  PostCard.swift
//  RedditReader
//
//  Created by Ivan Christian on 14/04/22.
//

import SwiftUI

struct PostCard: View {
    let post : Post;
    var body: some View {
        
        ZStack{
            VStack(alignment: .leading, spacing: 10){
                //TITLE
                Text(post.title)
                    .font(.headline)
                    .frame(maxWidth : .infinity, alignment: .topLeading)
                
                //THUMBNAIL
                if((post.thumbnail) != nil && post.thumbnail != "nsfw"){
                    AsyncImage(url: URL(string: post.thumbnail!)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .aspectRatio(contentMode: .fit)
                }
                
                
                //AUTHOR
                Text("by u/\(post.author) on r/\(post.subreddit)")
                    .font(.subheadline)
                    .frame(maxWidth : .infinity, alignment: .topLeading)
                
                //POST ACTION
                HStack() {
                    //UPVOTE BUTTON HERE
                    Label(String(post.score), systemImage: "arrow.up")
                    
                    //COMMENT NUM HERE
                    Label(String(post.numComments), systemImage: "bubble.right")
                    
                    //Post Time here
                    Label("11H", systemImage: "clock")
                }
            }
            .padding()
            .background(.regularMaterial).cornerRadius(16)
            
        }
        .frame(maxWidth : .infinity, alignment: .topLeading)
        
    }
}

//struct PostCard_Previews: PreviewProvider {
//    static var previews: some View {
//
//        //PostCard()
//    }
//}
