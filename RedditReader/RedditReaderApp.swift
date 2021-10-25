//
//  RedditReaderApp.swift
//  RedditReader
//
//  Created by Ivan Christian on 25/10/21.
//

import SwiftUI

@main
struct RedditReaderApp: App {
    let vm = PostsViewModel()
    var body: some Scene {
        WindowGroup {
            PostsView(postViewModel: vm)
        }
    }
}
