//
//  File.swift
//  sample
//
//  Created by Leandro Berli on 12/10/2022.
//

import Foundation

protocol ApodHTTPClientProtocol {
    func getApods(completion: @escaping ([Post]?,Error?) -> Void)
}

class ApodHTTPClient: ApodHTTPClientProtocol {
    
    private let apiKey = "Ayydsno3tTZLhkYVsT53Vy4pQYzHL4kJSJG2JPDu"
    private let baseURL = "https://api.nasa.gov/planetary/apod"
    
    func getApods(completion: @escaping ([Post]?,Error?) -> Void) {
        guard let url = URL(string: baseURL) else {
            return
        }
        
        var request = URLRequest(url: url)
        let queryItem = URLQueryItem(name: "api_key", value: apiKey)
        let dateQueryItem = URLQueryItem(name: "start_date", value: "2022-10-10")
        request.url?.append(queryItems: [queryItem, dateQueryItem])
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let err = error {
                print(err.localizedDescription)
                completion(nil,err)
                return
            }
            if let data = data, let string = String(data: data, encoding: .utf8) {
                print(string)
                do {
                    let post = try JSONDecoder().decode([Post].self, from: data)
                    completion(post,nil)
                } catch {
                    print("JSON Error: ", error.localizedDescription)
                }
            }
        }.resume()
    }
    
}
