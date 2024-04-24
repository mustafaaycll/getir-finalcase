//
//  ImageCacheManager.swift
//  getir-finalcase
//
//  Created by Mustafa Yücel on 23.04.2024.
//

import Foundation
import UIKit

class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
}
