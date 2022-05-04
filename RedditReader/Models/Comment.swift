//
//  Comment.swift
//  RedditReader
//
//  Created by Ivan Christian on 01/12/21.
//

import Foundation

extension ListingResponse where T == Comment {
    public var comments: [Comment] {
        data?.children.map{ $0.data } ?? []
    }
}

public struct Comment: Decodable, Identifiable {
    public let id: String
    public let name: String
    public let body: String?
    public let isSubmitter: Bool?
    public let author: String?
    public let lindId: String?
    public let parentId: String?
    public let created: Date?
    public let createdUtc: Date?
    public let replies: Replies?
    public var score: Int?
    public var likes: Bool?
    public var saved: Bool?
    
    public let permalink: String?
    public var permalinkURL: URL? {
        guard let permalink = permalink else { return nil }
        return URL(string: "https://reddit.com\(permalink)")
    }
    
    public let authorFlairText: String?
    public let authorFlairTextColor: String?
    public let authorFlairBackgroundColor: String?
    
    public var repliesComments: [Comment]? {
        if let replies = replies {
            switch replies {
            case let .some(replies):
                return replies.data?.children.map{ $0.data }
            default:
                return nil
            }
        }
        return nil
    }
}

public enum Replies: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            self = .some(try container.decode(ListingResponse<Comment>.self))
        } catch {
            self = .none(try container.decode(String.self))
        }
    }
    
    case some(ListingResponse<Comment>)
    case none(String)
}
