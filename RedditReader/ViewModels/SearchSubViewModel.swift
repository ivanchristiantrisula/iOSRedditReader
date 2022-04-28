//
//  SearchViewModel.swift
//  RedditReader
//
//  Created by Ivan Christian on 28/04/22.
//

import Foundation

class SearchSubViewModel : ObservableObject{
    @Published var subs : [SearchSubListingChild] = [];
    @Published var keyword : String = ""
    
    
    init(){}
    
    enum loadingStateEnum{
        case IDLE
        case LOADING
        case ERROR
    }
    
    var loadingState : loadingStateEnum = .IDLE
    
    func fetchSubs (_ keyword : String) {
        print("masok")
        loadingState = .LOADING
        callFetchAPI(keyword) { result, error in
            if let error = error {
                print(error.localizedDescription)
                self.loadingState = .ERROR
            }
            if let result = result {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do{
                    let decoded = try decoder.decode(SearchSubMostOuter.self, from: result)
                    
                    DispatchQueue.main.async {
                        self.subs = decoded.data?.children ?? []
                        
                        self.loadingState = .IDLE
                    }
                    
                }catch{
                    print("Error decoding post \(error)")
                }
                 
            }
            
        }
    }
    
    private func callFetchAPI (_ keyword : String, completion: @escaping (_ data: Data?, _ error: Error?) -> Void) {
        let url = "https://www.reddit.com/search/.json?q=\(keyword)&type=sr"
        
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
    
    
    
}
