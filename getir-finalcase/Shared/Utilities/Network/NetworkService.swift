//
//  NetworkService.swift
//  getir-finalcase
//
//  Created by Mustafa Yücel on 13.04.2024.
//

import Foundation
import Moya

enum NetworkService {
    case getProducts
    case getSuggestedProducts
}

extension NetworkService: TargetType {
    var baseURL: URL {
        return URL(string: "https://65c38b5339055e7482c12050.mockapi.io/api")!
    }
    
    var path: String {
        switch self {
        case .getProducts:
            return "/products"
        case .getSuggestedProducts:
            return "/suggestedProducts"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getProducts:
            return .get
        case .getSuggestedProducts:
            return .get
        }
    }
    
    var task: Moya.Task {
        .requestPlain
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    
}
