//
//  CommentView.swift
//  RedditReader
//
//  Created by Ivan Christian on 02/12/21.
//

import SwiftUI

struct CommentView: View {
    @ObservedObject var commentViewModel : CommentsViewModel
    
    var body: some View {
        
        List{
            RecursiveReply(comments: commentViewModel.comments, depth: 0)
        }
        .listStyle(PlainListStyle())
        .listRowSeparator(.hidden)
    }
}

struct RecursiveReply: View {
    let comments : [Comment]
    let depth : Int
    
    var body: some View {
        ForEach(comments){comment in
            if(comment.body == nil && comment.author == nil && comment.created == nil){
                Button {
                    //do something
                } label: {
                    Label("Load more comment", systemImage: "bubble.right.fill")
                }.padding(.leading, CGFloat(depth)*10)

            }else{
                CommentCard(comment: comment, depth : depth)
                    .onTapGesture {
                        print(comment)
                    }
                if(comment.repliesComments != nil){
                    RecursiveReply(comments: comment.repliesComments!, depth: self.depth+1)
                }
            }
            
            
        }
    }
}

//struct CommentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentView()
//    }
//}
