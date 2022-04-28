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
        NavigationView{
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
                                    NavigationLink("", destination: {
                                        switch post.url.getUrlType(){
                                        case .image :
                                            FullImageView(imageURL: post.url)
                                        default :
                                           WebView()
                                        }
                                    })
                                    
                                    
                                        
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
            .listRowSeparator(.hidden)
        }
        
            
        
    }
}


extension String {
    enum UrlType {
        case image, video, other
    }
    func getUrlType() -> UrlType{
        let imageExts = ["jpeg", "jpg", "png", "gif", "webp", "svg"]
        let videoExts = [".mp4",".avi", "webm"]
        
        let url = URL(string: self)
        let pathExt = url?.pathExtension
        
        if(imageExts.contains(pathExt!)){
            return .image
        }else if(videoExts.contains(pathExt!)){
            return .video
        }else{
            return .other
        }
    }
}



struct PostsView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = PostsViewModel()
        PostsView(postViewModel: vm)
    }
}
