//
//  SearchView.swift
//  RedditReader
//
//  Created by Ivan Christian on 28/04/22.
//

import SwiftUI


struct SearchView: View {
    
    @ObservedObject var searchSubVM = SearchSubViewModel()
    @State var searchText: String = ""
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
                        VStack(alignment: .leading) {
                            Text(String(sub.data.displayName))
                            Divider()
                        }
                        
                        Spacer()
                    }
                }
            }.navigationTitle(Text("Search"))
        }
    }
}



extension UIImageView {

    func addInitials(first: String, second: String) {
        let initials = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
        initials.center = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
        initials.textAlignment = .center
        initials.text = first + " " + second
        initials.textColor = .black
        self.addSubview(initials)
    }
}
