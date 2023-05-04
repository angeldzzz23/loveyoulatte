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

typealias Parameters = [String: String]

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
    
    static func uploadingImage2(parameters: Parameters, mediaImage: Media2, completion: @escaping (Result<String?, Error>) -> Void)  {
        
        guard let url = URL(string: "http://loveyoulatte.duckdns.org:5000/api/products") else { return }
        var request = URLRequest(url: url)

        request.httpMethod = "POST"
        
        let boundary = generateBoundary()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let dataBody = createDataBody(withParameters: parameters, media: [mediaImage], boundary: boundary)
        request.httpBody = dataBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
                
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])

                    completion(.success("Success"))
                    
                } catch {
                    completion(.failure(error))
                }
            }
            }.resume()
   
    }
    
    
    
    
    // uploading image
    // https://www.youtube.com/watch?v=8GH0yMPvQFU
    static func uploadingImage(parameters: Parameters, mediaImage: Media2) {
        
        guard let url = URL(string: "http://loveyoulatte.duckdns.org:5000/api/products") else { return }
        var request = URLRequest(url: url)

        request.httpMethod = "POST"
        
        let boundary = generateBoundary()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let dataBody = createDataBody(withParameters: parameters, media: [mediaImage], boundary: boundary)
        request.httpBody = dataBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
            }.resume()
   
    }
    
    static func generateBoundary() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    
    static func createDataBody(withParameters params: Parameters?, media: [Media2]?, boundary: String) -> Data {
        
        let lineBreak = "\r\n"
        var body = Data()
        
        if let parameters = params {
            for (key, value) in parameters {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                body.append("\(value + lineBreak)")
            }
        }
        
        if let media = media {
            for photo in media {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.filename)\"\(lineBreak)")
                body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
                body.append(photo.data)
                body.append(lineBreak)
            }
        }
        
        body.append("--\(boundary)--\(lineBreak)")
        
        return body
    }
    
}

// extending data
extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}

