//
//  NetworkService.swift
//  HW2
//
//  Created by Майя Герасимова on 01.12.2020.
//

import Foundation

class NetworkService{
    
    static func loadLines(completion: @escaping ([Line], Error?) -> Void) {
        guard let url = URL(string: "https://api.hh.ru/metro/") else{
            let error = NSError(domain: "Invalid URl", code: -123, userInfo: nil)
            completion([], error)
            return
        }
        
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
                let error = NSError(domain: "Data Error Occured. Response Status Code: \(response.statusCode)", code: response.statusCode, userInfo: nil)
                DispatchQueue.main.async {
                    completion([], error)
                }
                print("Data Error Occured. Response Status Code: \(response.statusCode)")
                return
            }
            
            do {
                let metro = try JSONDecoder().decode([Metro].self, from: data)
                
                let lines = metro[3].lines
                //let lines = [Line(name:"A")]
                
                DispatchQueue.main.async {
                    completion(lines, nil)
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
