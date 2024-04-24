//
//  Category.swift
//  getir-finalcase
//
//  Created by Mustafa Yücel on 13.04.2024.
//

import Foundation

struct Category: Codable {
    let id: String
    let name: String
    let products: [Product]
    
    var countOfProducts: Int {
        return products.count
    }
}
