//
//  Search.swift
//  RedditReader
//
//  Created by Ivan Christian on 28/04/22.
//

import Foundation

struct Subreddit : Decodable, Identifiable, Equatable, Hashable {
    let id : String
    let publicDescription : String?
    let displayName : String
    let created : Float
    let displayNamePrefixed : String
    let iconImg : String?
}

struct SearchSubMostOuter : Decodable {
    let data : SearchSubOuterData?
}

struct SearchSubOuterData : Decodable, Equatable {
    let children: [SearchSubListingChild]?}

struct SearchSubListingChild : Decodable, Hashable {
    let kind : String
    let data : Subreddit
}
