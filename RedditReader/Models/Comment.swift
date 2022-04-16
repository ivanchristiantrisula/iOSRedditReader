//
//  Comment.swift
//  RedditReader
//
//  Created by Ivan Christian on 01/12/21.
//

import Foundation

struct Comment {
    var body : String
    var score : Int
    var author : String
    var isSubmitter : Bool
    var created : Float
    var replies : CommentAPIResponseMostOuter?
}

struct CommentAPIResponseMostOuter {
   var data : CommentAPIResponseOuter
}

struct CommentAPIResponseOuter{
    var children : [Comment]
}
