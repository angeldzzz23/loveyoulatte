//
//  API.swift
//  LoveYouLatte
//
//  Created by Angel Zambrano on 5/3/23.
//

import Foundation

enum APIERRORS: Error {
    case limit
}

// TODO:
struct API {
    
    let baseUrl = "http://loveyoulatte.duckdns.org:5000/api/products"
    
    
    func gettingProducts(completion: @escaping (Result<Products?, Error>) -> Void) {
        // setting up the end point
        guard var url2 = URLComponents(string: "http://loveyoulatte.duckdns.org:5000/api/products") else {return}

        print(url2)
        
        // setting up the request
        var request = URLRequest(url: url2.url!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let searchResponse = try decoder.decode(Products.self, from: data) // gets the artists
                    completion(.success(searchResponse))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
        
    }
    
    
    
    
}
