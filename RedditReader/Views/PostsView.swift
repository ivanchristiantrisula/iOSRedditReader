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
        ScrollView{
            
            if(postViewModel.posts != nil){
                ForEach(postViewModel.posts!){ post in
                    LazyVStack(alignment: .leading){
                        ZStack{
                            Rectangle().foregroundColor(Color.white).border(.black)
                            Text("\(post.title)")
                                .onAppear {
                                    if(post == postViewModel.posts?.last){
                                        postViewModel.getAfterPosts()
                                    }
                                }
                        }
                        
                    }
                    .padding()
                }
                    
            }
            if(postViewModel.loadingState == .LOADING){
                ProgressView().scaleEffect(1)
            }
        }
        .padding(.vertical, 2.0)
        
    }
}

//struct PostsView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostsView()
//    }
//}
