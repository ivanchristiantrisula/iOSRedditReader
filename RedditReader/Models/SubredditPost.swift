//
//  SubredditPost.swift
//  RedditReader
//
//  Created by Ivan Christian on 04/05/22.
//

import Foundation

public struct SubredditPost: Decodable, Identifiable, Hashable {
    public static func == (lhs: SubredditPost, rhs: SubredditPost) -> Bool {
        lhs.id == rhs.id &&
            lhs.likes == rhs.likes &&
            lhs.saved == rhs.saved
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public let id: String
    public let name: String
    public let title: String
    public let numComments: Int
    public let subreddit: String
    public let thumbnail: String
    public let created: Date
    public let createdUtc: Date
    public var thumbnailURL: URL? {
        guard thumbnail.hasPrefix("http"),
              let url = URL(string: thumbnail) else {
            return nil
        }
        return url
    }
    public let author: String
    public let selftext: String?
    public let description: String?
    public var ups: Int
    public let downs: Int
    public let url: String?
    public let permalink: String?
    
    public let linkFlairText: String?
    public let linkFlairBackgroundColor: String?
    public let linkFlairTextColor: String?
    
    public let authorFlairText: String?
    public let authorFlairTextColor: String?
    public let authorFlairBackgroundColor: String?
    
    public var visited: Bool
    public var saved: Bool
    public var redditURL: URL? {
        if let permalink = permalink, let url = URL(string: "https://reddit.com\(permalink)") {
            return url
        }
        return nil
    }
    public var likes: Bool?
}

