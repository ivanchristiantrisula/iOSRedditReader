//
//  SearchView.swift
//  RedditReader
//
//  Created by Ivan Christian on 28/04/22.
//

import SwiftUI
import Kingfisher
import InitialsUI


struct SearchView: View {
    @ObservedObject var searchSubVM = SearchSubViewModel()
    @State var searchText: String = ""
    @ObservedObject var postVM : PostsViewModel;
    @Binding var tabSelection: Int
    
    var body: some View {
        NavigationView{
            List{
                TextField("Search Subreddit", text : $searchText)
                    .padding(7)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .onChange(of: searchText) { newValue in
                        if(searchText.count > 2){
                            searchSubVM.fetchSubs(searchText)
                        }
                        
                    }
                ForEach(searchSubVM.subs, id: \.self){sub in
                    HStack(alignment: .top) {
                        if(sub.data.iconImg != nil){
                            KFImage
                                .url(URL(string : sub.data.iconImg ?? ""))
                                .loadDiskFileSynchronously()
                                .cacheMemoryOnly()
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 30, height: 30)
                                .clipShape(Circle())
                        }else{
                            InitialsUI(initials: String(sub.data.displayName.prefix(1)).uppercased(), useDefaultForegroundColor: true, fontWeight: .bold)
                                .frame(width: 30, height: 30)
                                .clipShape(Circle())
                        }
                        VStack(alignment: .leading) {
                            Text(String(sub.data.displayName))
                        }
                        
                        Spacer()
                    }
                    .onTapGesture {
                        postVM.changeSubreddit(sr: sub.data.displayNamePrefixed)
                    }
                }
            }.navigationTitle(Text("Search"))
        }
    }
}
