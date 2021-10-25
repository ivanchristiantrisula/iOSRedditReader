//
//  PostsViewModel.swift
//  RedditReader
//
//  Created by Ivan Christian on 25/10/21.
//

import Foundation

class PostsViewModel {
    var posts : [Post]?
    
    init(){
        fetchPosts("/") { result, error in
            if let error = error {
                print(error.localizedDescription)
            }
            if let result = result {
                print(result)
            }
        }
    }
    
    func fetchPosts (_ subreddit : String, completion: @escaping (_ data: Any?, _ error: Error?) -> Void) {
        let url = URL(string: "https://www.reddit.com\(subreddit).json")!
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            do {
                if let data = data {
                    let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments])
                    completion(json, nil)
                } else {
                    completion(nil, nil)
                }
            } catch {
                completion(nil, error)
            }
        })
        task.resume()
    }
}
