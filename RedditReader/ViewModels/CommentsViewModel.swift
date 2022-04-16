//
//  CommentsViewModel.swift
//  RedditReader
//
//  Created by Ivan Christian on 17/04/22.
//

import Foundation

class CommentsViewModel : ObservableObject {
    let post : Post;
    @Published var comments : [Comment] = []
    
    init(_ post:Post){
        self.post = post
    }
    
    func fetchComments() {
        
    }
}
