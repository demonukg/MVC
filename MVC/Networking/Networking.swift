//
//  Networking.swift
//  MVC
//
//  Created by Dmitry Y. on 5/9/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import Alamofire

final class Networking {
    
    static func request<T: Decodable>(_ urlRequest: URLRequestConvertible, result: @escaping(Swift.Result<T, Swift.Error>) -> Void) {
        AF.request(urlRequest).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                result(.success(value))
            case .failure(let error):
                
                switch response.response?.statusCode {
                case 403:
                    result(.failure(Error.forbidden))
                case 404:
                    result(.failure(Error.notFound))
                case 409:
                    result(.failure(Error.conflict))
                case 500:
                    result(.failure(Error.internalServerError))
                default:
                    result(.failure(Error.descripted(code: response.response?.statusCode, description: error.localizedDescription)))
                }
            }
        }
    }
    
}

extension Networking {
    
    enum Error: Swift.Error {
        case forbidden
        case notFound
        case conflict
        case internalServerError
        case descripted(code: Int?, description: String)
    }
    
}

extension Networking.Error: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .forbidden:
            return "Status code 403"
        case .notFound:
            return "Status code 404"
        case .conflict:
            return "Status code 409"
        case .internalServerError:
            return "Status code 500"
        case let .descripted(code, description):
            return "An error was found" + "\n" + "Code" + ": " + "\(String(describing: code))" + "\n" + "Description" + ": " + description
        }
    }
    
}
