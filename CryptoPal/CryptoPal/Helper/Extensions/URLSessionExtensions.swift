//
//  URLSessionExtensions.swift
//  CryptoBuddy
//
//  Created by Mihindu de Silva on 10/05/2019.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import Foundation

extension URLSession {
    func dataTask ( with url: URL, result: @escaping (Result<(URLResponse, Data), Error>) -> Void) -> URLSessionDataTask {
        
        return dataTask(with: url) { (data, response, error) in
            if let error = error {
                result(.failure(error))
                return
            }
            guard let response = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                result(.failure(error))
                return
            }
            
            result(.success((response, data)))
        }
    }
}

