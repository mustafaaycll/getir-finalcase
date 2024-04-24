//
//  Product.swift
//  getir-finalcase
//
//  Created by Mustafa Yücel on 13.04.2024.
//

import Foundation
import UIKit

struct Product: Codable, Hashable {
    let id: String
    let name: String
    let price: Double
    let priceText: String
    let attribute: String?
    
    let imageURL: String?
    let thumbnailURL: String?
    let squareThumbnailURL: String?
    
    var availableImageURL: String {
        return imageURL ?? thumbnailURL ?? squareThumbnailURL ?? ""
    }
}
