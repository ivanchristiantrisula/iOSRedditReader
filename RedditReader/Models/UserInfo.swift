//
//  UserInfo.swift
//  RedditReader
//
//  Created by Ivan Christian on 08/05/22.
//

import Foundation

public struct ProfileListingResponse : Decodable {
    public let kind : String
    public let data : UserInfo
}

public struct UserInfo : Decodable, Identifiable {
    public let id: String
    public let name : String
    public let snoovatarImg : String!
    public let commentKarma : Int
    public let isMod : Bool
    public let isEmployee : Bool
    public let linkKarma : Int
    public let created : Float
}


