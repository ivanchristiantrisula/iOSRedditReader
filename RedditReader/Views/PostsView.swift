//
//  PostsView.swift
//  RedditReader
//
//  Created by Ivan Christian on 25/10/21.
//

import SwiftUI

struct PostsView: View {
    @ObservedObject var postViewModel : PostsViewModel
    var body: some View {
        posts
            
    }
    
    var posts: some View {
        
            
        List{
            if(postViewModel.posts != nil){
                ForEach(postViewModel.posts!){ post in
                        PostCard(post: post)
                            .onAppear(){
                                if(self.postViewModel.posts?.last == post){
                                    postViewModel.getAfterPosts()
                                }
                            }
                            .background(
                                NavigationLink("",destination : CommentView(commentViewModel: CommentsViewModel(post)))
                                    .opacity(0)
                            ) //remove navigation link shitty arrow.
                            
                            
                    
                }
                .listRowInsets(EdgeInsets())
                .padding(.vertical)
                
            }
            if(postViewModel.loadingState == .LOADING){
                ProgressView().scaleEffect(1)
            }
        }
        .navigationTitle("Frontpage")
        .listStyle(PlainListStyle())
        
            
        
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

struct PostsView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = PostsViewModel()
        PostsView(postViewModel: vm)
    }
}
