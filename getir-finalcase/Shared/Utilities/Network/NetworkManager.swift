//
//  NetworkManager.swift
//  getir-finalcase
//
//  Created by Mustafa Yücel on 13.04.2024.
//
import Foundation
import RxSwift
import RxMoya
import Moya

enum NetworkError: Error {
    case unknown
}

struct NetworkManager {
    static let shared = NetworkManager()
    
    private let provider = MoyaProvider<NetworkService>()
    
    func getProducts() -> Single<[Category]> {
        return provider.rx.request(.getProducts).filterSuccessfulStatusAndRedirectCodes().map { response -> Response in
            let json = try JSONSerialization.jsonObject(with: response.data, options: []) as? [[String: Any]]
            var categories: [[String: Any]] = []
            if let json = json {
                for elem in json {
                    if elem["products"] != nil {
                        categories.append(elem)
                    }
                }
            }
            let data = try JSONSerialization.data(withJSONObject: categories, options: [])
            return Response(statusCode: response.statusCode, data: data, request: response.request, response: response.response)
        }.map([Category].self)
    }
    
    func getSuggestedProducts() -> Single<[Category]> {
        return provider.rx.request(.getSuggestedProducts).filterSuccessfulStatusAndRedirectCodes().map { response -> Response in
            let json = try JSONSerialization.jsonObject(with: response.data, options: []) as? [[String: Any]]
            var categories: [[String: Any]] = []
            if let json = json {
                for elem in json {
                    if elem["products"] != nil {
                        categories.append(elem)
                    }
                }
            }
            let data = try JSONSerialization.data(withJSONObject: categories, options: [])
            return Response(statusCode: response.statusCode, data: data, request: response.request, response: response.response)
        }.map([Category].self)
    }
}
