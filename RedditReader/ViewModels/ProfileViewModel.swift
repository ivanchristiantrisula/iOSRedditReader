//
//  ProfileViewModel.swift
//  RedditReader
//
//  Created by Ivan Christian on 10/05/22.
//

import Foundation

class ProfileViewModel : ObservableObject {
    let user : String
    @Published var userInfo : UserInfo?
    
    init(_ user : String){
        self.user = user
        
    }
    
    func fetchProfile (){
        callFetchProfileAPI() { result, error in
            if let error = error {
                print(error.localizedDescription)
            }
            if let result = result {
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do{
                    let decoded = try decoder.decode(ProfileListingResponse.self, from:result)
                    
                    DispatchQueue.main.async {
                        self.userInfo = decoded.data
                    }
                    
                }catch{
                    print("Error decoding post \(error)")
                }
                 
            }
            
        }
    }
    
    private func callFetchProfileAPI (completion: @escaping (_ data: Data?, _ error: Error?) -> Void) {
        let url = "https://www.reddit.com/u/\(user)/about/.json"
        print(url)
//        if(after != nil){
//            url+="after="+after!
//        }
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
