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
    @State var openComment : Bool = false
    @State var showAuthor : Bool = false
    @State var showSR : Bool = false
    @State var showMedia : Bool = false
    
    var body: some View {
        
        ZStack{
            VStack(alignment: .leading, spacing: 15){
                //TITLE
                Text(post.title)
                    .font(.headline)
                    .bold()
                    .onTapGesture(perform: {
                        self.openComment = true
                    })
                    .frame(maxWidth : .infinity, alignment: .topLeading)
                    .foregroundColor(post.stickied ? Color.green : Color.primary)
                
                //THUMBNAIL
                    if(post.thumbnail!.isValidURL){
                        ZStack{
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
                        }
                }
                
                //AUTHOR AND POST SUB
                HStack(){
                    Text("By")
                    
                    Text(post.author)
                    .foregroundColor(.accentColor)
                    .onTapGesture {
                        showAuthor.toggle()
                    }
                    
                    Text(" on ")
                    Text(post.subreddit)
                        .foregroundColor(Color.accentColor)
                        .onTapGesture {
                            showSR.toggle()
                        }
                }
                .font(.system(size: 15))
                
                //POST ACTION
                HStack() {
                    //UPVOTE BUTTON HERE
                    
                    Button {
                        //upvote
                    } label: {
                        Label(String(post.score)+"  ", systemImage: "arrow.up").padding(5)
                    }.overlay {
                        RoundedRectangle(cornerRadius: 25).strokeBorder(.white)
                    }

                    //COMMENT NUM HERE
                    Button {
                        self.openComment = true
                    } label: {
                        Label(String(post.numComments)+"  ", systemImage: "bubble.right").padding(5)
                    }.overlay {
                        RoundedRectangle(cornerRadius: 25).strokeBorder(.white)
                    }
                    
                    //Post Time here
                    
                    Button {
                        //upvote
                    } label: {
                        Label("11H"+"  ", systemImage: "clock").padding(5)
                    }.overlay {
                        RoundedRectangle(cornerRadius: 25).strokeBorder(.white)
                    }
                }
            }
            .padding()
            .background(.regularMaterial).cornerRadius(16)
            
            //hidden nav links
            ZStack{
                NavigationLink("", destination: ProfileView(profileViewModel: ProfileViewModel(post.author)), isActive: $showAuthor).hidden()
                NavigationLink("", destination: Text("SR"), isActive: $showSR).hidden()
                NavigationLink("", destination: FullImageView(imageURL: post.url), isActive: $showMedia).hidden()
                NavigationLink("", destination: CommentView(commentViewModel: CommentsViewModel(post)), isActive: $openComment )
            }.frame(width: 0, height: 0, alignment: .center)
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
