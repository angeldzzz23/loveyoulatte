//
//  API.swift
//  LoveYouLatte
//
//  Created by Angel Zambrano on 5/3/23.
//

import Foundation
import UIKit

enum APIERRORS: Error {
    case limit
}

enum StoreItemError: Error, LocalizedError {
    case itemsNotFound
    case imageDataMissing
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
    
    // downloading an image 
    func fetchImage(from url: URL) async throws -> UIImage {
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponents?.scheme = "http"
        
        if #available(iOS 15.0, *) {
            let (data, response) = try await URLSession.shared.data(from: urlComponents!.url!)
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                throw StoreItemError.imageDataMissing
            }
        
            guard let image = UIImage(data: data) else {
                throw StoreItemError.imageDataMissing
            }
            return image
        } else {
            // Fallback on earlier versions
            let image = UIImage()
            return image
        }
    
     
    } 
    
    
    
    
}
