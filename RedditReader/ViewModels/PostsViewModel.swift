//
//  PostsViewModel.swift
//  RedditReader
//
//  Created by Ivan Christian on 25/10/21.
//

import Foundation

class PostsViewModel: ObservableObject {
    @Published var posts : [Post]?
    @Published var subreddit = "/"
    @Published var loadingState : loadingStateEnum = .IDLE
    var after : String?
    
    enum loadingStateEnum{
        case IDLE
        case LOADING
        case ERROR
    }
    
    init(){
        fetchPosts("/r/indonesia")
    }
    
    func fetchPosts (_ subreddit : String) {
        loadingState = .LOADING
        callFetchPostAPI(subreddit) { result, error in
            if let error = error {
                print(error.localizedDescription)
                self.loadingState = .ERROR
            }
            if let result = result {
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do{
                    let decoded = try decoder.decode(PostMostOuter.self, from: result)
                    
                    DispatchQueue.main.async {
                        if(self.posts == nil){
                            self.posts = decoded.posts
                        }else{
                            self.posts!+=decoded.posts ?? []
                        }
                        
                        self.after = decoded.after
                        self.loadingState = .IDLE
                    }
                    
                }catch{
                    print("Error decoding post \(error)")
                }
                 
            }
            
        }
    }
    
    private func callFetchPostAPI (_ subreddit : String, completion: @escaping (_ data: Data?, _ error: Error?) -> Void) {
        var url = "https://www.reddit.com\(subreddit).json?"
        
        if(after != nil){
            url+="after="+after!
        }
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            if let error = error {
                completion(nil, error)
            }
            
            if let data = data {
                completion(data, nil)
            } else {
                completion(nil, nil)
            }
        })
        task.resume()
    }
    
    func getAfterPosts(){
        fetchPosts(subreddit)
    }
    
    private struct PostMostOuter : Decodable {
        let data : PostOuterData?
        
        var posts: [Post]? {
            return data?.children?.map {$0.data}
        }
        var after : String?{
            return data?.after
        }
    }
    
    private struct PostOuterData : Decodable {
        let children: [PostListingChild]?
        let after : String
    }
    
    private struct PostListingChild : Decodable {
        let data : Post
    }
    
    
}
