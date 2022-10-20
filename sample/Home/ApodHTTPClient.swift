//
//  File.swift
//  sample
//
//  Created by Leandro Berli on 12/10/2022.
//

import Foundation

//TODO: Error handling

protocol ApodHTTPClientProtocol {
    func getApods(completion: @escaping ([Post]?,Error?) -> Void)
}

class ApodHTTPClient: ApodHTTPClientProtocol {
    
    private let apiKey = "Ayydsno3tTZLhkYVsT53Vy4pQYzHL4kJSJG2JPDu"
    private let baseURL = "https://api.nasa.gov/planetary/apod"
    
    func getApods(completion: @escaping ([Post]?,Error?) -> Void) {
        guard let request = getBasicURLRequest(with: baseURL) else {
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let err = error {
                print(err.localizedDescription)
                completion(nil,err)
                return
            }
            if let data = data, let _ = String(data: data, encoding: .utf8) {
                //print(string)
                do {
                    var post = try JSONDecoder().decode([Post].self, from: data)
                    post.removeAll(where:  { $0.url.contains(".gif")})
                    completion(post,nil)
                } catch {
                    print("JSON Error: ", error.localizedDescription)
                }
            }
        }.resume()
    }
    
    private func getBasicURLRequest(with urlString: String) -> URLRequest? {
        var urlComps = URLComponents(string: urlString)
        urlComps?.queryItems = [getAPIKeyQueryItem(), getStartDateQueryItem()]
        
        guard let url = urlComps?.url else {
            print("Error getting URL Request")
            return nil
        }
        
        return URLRequest(url: url)
    }
    
    private func getAPIKeyQueryItem() -> URLQueryItem {
        return URLQueryItem(name: "api_key", value: apiKey)
    }
    
    private func getStartDateQueryItem() -> URLQueryItem {
        return URLQueryItem(name: "start_date", value: "2022-10-10")
    }
    
}
