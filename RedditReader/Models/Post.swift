//
//  Post.swift
//  RedditReader
//
//  Created by Ivan Christian on 25/10/21.
//

import Foundation

struct Post : Decodable, Identifiable, Equatable {
    let id : String
    let title : String
    let subreddit : String
    let numComments : Int
    let author : String
    let createdUtc: Float
    let thumbnail : String?
    let clicked : Bool
    let score : Int
}
