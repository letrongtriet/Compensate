//
//  NetworkManager.swift
//  Compensate
//
//  Created on 23.5.2020.
//  Copyright © 2020 Compensate. All rights reserved.
//

import Foundation

public enum PostSection: String {
    case Hot = "hot"
    case Top = "top"
    case New = "new"
}

typealias Closure<T> = (T) -> Void

public final class NetworkManager {
    
    private init() {}
    
    static let shared = NetworkManager()
    
    private let baseUrlString = "https://www.reddit.com/r/ClimateActionPlan/{section}.json?count=50"
    
    func getPosts(section: PostSection, successfulCallback: Closure<[Post]>?, errorCallback: Closure<String>?) {
        let urlString = baseUrlString.replacingOccurrences(of: "{section}", with: section.rawValue)
        
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                errorCallback?("Oops! Something went wrong.")
            }
            return
        }
        
        var request = URLRequest(url: url, timeoutInterval: 30)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    errorCallback?(error.localizedDescription)
                }
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                    let value = try decoder.decode(SubReddit.self, from: data)
                    
                    DispatchQueue.main.async {
                        successfulCallback?(value.data.posts)
                    }
                } catch {
                    DispatchQueue.main.async {
                        errorCallback?(error.localizedDescription)
                    }
                }
            }
        }

        task.resume()
    }
    
}
