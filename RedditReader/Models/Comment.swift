//
//  Comment.swift
//  RedditReader
//
//  Created by Ivan Christian on 01/12/21.
//

import Foundation

struct Comment: Decodable, Identifiable ,Hashable{
    var id: String
    var body : String
    var score : Int
    var author : String
    var isSubmitter : Bool
    var created : Float
    var replies : CommentAPIResponseMostOuter?
}

struct CommentAPIResponseMostOuter : Decodable,Hashable{
   var data : CommentAPIResponseOuter
}

struct CommentAPIResponseOuter : Decodable,Hashable{
    var children : [CommentAPIResponseListing]
}

struct CommentAPIResponseListing : Decodable, Hashable{
    var data : Comment
}

