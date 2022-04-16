//
//  RedditReaderApp.swift
//  RedditReader
//
//  Created by Ivan Christian on 25/10/21.
//

import SwiftUI

@main
struct RedditReaderApp: App {
    @State var activePage = "post"
    @State var comment = ""
    
    let vm = PostsViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationView{
                PostsView(postViewModel: vm)
            }
            
        }
    }
}
