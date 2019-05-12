//
//  RequestApiData.swift
//  CryptoBuddy
//
//  Created by Mihindu de Silva on 08/05/2019.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import Foundation

class CurrencyServiceAPI {
    
    public static let shared = CurrencyServiceAPI()
    
    private let scheme = "https"
    private let hostString = "bx.in.th"
    private let apiPath = "/api/"
    private let tradeHistoryPath = "tradehistory/"
    
    lazy private var apiURLComponents : URLComponents = {
        var components = URLComponents()
        components.scheme = self.scheme
        components.host = self.hostString
        components.path = self.apiPath
        return components
    }()
    
    private let urlSession = URLSession.shared
    
    let jsonDecoder : JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
    
    typealias PairingData = [String : CurrencyPairing]
    
    private func requestData<T: Decodable>(url : URL, completionHandler : @escaping (Result<T, APIServiceError>) -> Void)
    {
        guard URLComponents(url: url, resolvingAgainstBaseURL: true) != nil else {
            completionHandler(.failure(.invalidEndpoint))
            return
        }
        
        urlSession.dataTask(with: url) { (result) in
            switch(result)
            {
            case .success(let (response, data)):
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                    completionHandler(.failure(.invalidResponse))
                    return
                }
                do {
                    let values = try self.jsonDecoder.decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completionHandler(.success(values))
                    }
                } catch {
                    completionHandler(.failure(.decodeError))
                }
            case .failure( _):
                completionHandler(.failure(.apiError))
            }
            }.resume()
    }
    
    public func getData(result : @escaping (Result<PairingData, APIServiceError>) -> Void)
    {
        guard let apiUrl = apiURLComponents.url  else {
            print("Unknown api url")
            return
        }
        requestData(url: apiUrl, completionHandler: result)
    }
    
    public func getHistory(for currencyPairingID : Int, at date : String, result : @escaping (Result<CurrencyHistoricalData, APIServiceError>) -> Void)
    {
        var components = apiURLComponents
        components.path = "/api/tradehistory/"
        
        components.queryItems = [
            URLQueryItem(name: "pairing", value: String(currencyPairingID)),
            URLQueryItem(name: "date", value: date)
        ]
        
        guard let url = components.url else {
            print("Unknown trade history api url")
            return
        }
        
        requestData(url: url, completionHandler: result)
        
    }
    
    
    public enum APIServiceError : Error {
        case apiError
        case invalidEndpoint
        case invalidResponse
        case noData
        case decodeError
    }
    
    
}

