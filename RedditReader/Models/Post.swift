//
//  Post.swift
//  RedditReader
//
//  Created by Ivan Christian on 25/10/21.
//

import Foundation

struct Post : Decodable {
    var title : String
    var subreddit : String
    var scores : Int
    var num_comments : Double
    var author : String
    var created_utc: Float
    var thumbnail : URL
    var clicked : Bool
}
