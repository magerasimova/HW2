//
//  NetworkService.swift
//  HW2
//
//  Created by Майя Герасимова on 01.12.2020.
//

import Foundation

class NetworkService{
    
    
    static func loadPosts(completion: @escaping ([Post], Error?) -> Void) {
        
//        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else{
//            let error = NSError(domain: "dfghjk", code: -23456, userInfo: nil)
//            completion([], error)
//            return
//        }
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15
        let session = URLSession(configuration: configuration)
        
        
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
                DispatchQueue.main.async {
                    completion([], error)
                }
                return
            }
            
            let response = response as! HTTPURLResponse
            guard let data = data else {
                //error handling
                let error = NSError()
                DispatchQueue.main.async {
                    completion([], error)
                }
                print("Data Error Occured. Response Status Code: \(response.statusCode)")
                return
            }
            
            do {
                
                let posts = try JSONDecoder().decode([Post].self, from: data)
                
                DispatchQueue.main.async {
                    completion(posts, nil)
                }
                
            }
            catch (let jsonError) {
                print(jsonError)
                DispatchQueue.main.async {
                    completion([], jsonError)
                }
            }
            
        }
        
        task.resume()
    }

    
}
