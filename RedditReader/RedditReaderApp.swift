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
    @State private var tabSelection = 1
    @State var postVM = PostsViewModel()
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $tabSelection){
                PostsView(postViewModel: postVM)
                    .tabItem {
                        Label("Posts", systemImage: "newspaper")
                    }
                    .tag(1)
                
                SearchView(postVM : self.postVM, tabSelection: $tabSelection)
                    .tabItem{
                        Label("Search", systemImage: "magnifyingglass")
                    }
                    .tag(2)
                
            }
            
        }
    }
}
