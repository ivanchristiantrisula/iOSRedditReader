//
//  PostCard.swift
//  RedditReader
//
//  Created by Ivan Christian on 14/04/22.
//

import SwiftUI
import Kingfisher

struct PostCard: View {
    let post : Post;
    var body: some View {
        
        ZStack{
            VStack(alignment: .leading, spacing: 10){
                //TITLE
                Text(post.title)
                    .font(.headline)
                    .frame(maxWidth : .infinity, alignment: .topLeading)
                    .foregroundColor(post.stickied ? Color.green : Color.primary)
                
                //THUMBNAIL
                if(post.thumbnail!.isValidURL){
                    KFImage
                        .url(URL(string : post.thumbnail ?? ""))
                        .loadDiskFileSynchronously()
                        .placeholder { progress in
                            ProgressView();
                        }
                        .cacheMemoryOnly()
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth : .infinity, alignment: .center)
                        .background(
                            NavigationLink("", destination: {
                                switch post.url.getUrlType(){
                                case .image :
                                    FullImageView(imageURL: post.url)
                                default :
                                   WebView()
                                }
                            })
                        )
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

extension String {
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.utf16.count
        } else {
            return false
        }
    }
    
    
    
    
}

//struct PostCard_Previews: PreviewProvider {
//    static var previews: some View {
//
//        //PostCard()
//    }
//}
