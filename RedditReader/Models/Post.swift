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
    let permalink : String
    let url : String
    let stickied : Bool
}

struct PostMostOuter : Decodable {
    let data : PostOuterData?
    
    var posts: [Post]? {
        return data?.children?.map {$0.data}
    }
    var after : String?{
        return data?.after
    }
}

struct PostOuterData : Decodable {
    let children: [PostListingChild]?
    let after : String?
}

struct PostListingChild : Decodable {
    let data : Post
}
