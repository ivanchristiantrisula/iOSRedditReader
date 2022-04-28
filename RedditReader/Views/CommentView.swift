//
//  CommentView.swift
//  RedditReader
//
//  Created by Ivan Christian on 02/12/21.
//

import SwiftUI

struct CommentView: View {
    @ObservedObject var commentViewModel : CommentsViewModel;
    var body: some View {
        
        List{
            ForEach(commentViewModel.comments, id: \.self) { comment in
                Text(comment.data.body)
            }
        }
        .navigationTitle("\(String(commentViewModel.post.numComments)) Comments")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//struct CommentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentView()
//    }
//}
