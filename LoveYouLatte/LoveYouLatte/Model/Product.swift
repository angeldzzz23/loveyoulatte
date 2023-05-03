//
//  Product.swift
//  LoveYouLatte
//
//  Created by Angel Zambrano on 5/3/23.
//

import Foundation

// MARK: - Welcome
struct Products: Codable {
    let coffee, matcha, signature, tea: [Product]?
}

// MARK: - Coffee
struct Product: Codable {
    let id: Int
    let imageName: String
    let imageURL: String
    let name, price: String

    enum CodingKeys: String, CodingKey {
        case id, imageName
        case imageURL = "image_url"
        case name, price
    }
}
