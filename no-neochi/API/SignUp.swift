//
//  LoginProtocol.swift
//  no-neochi
//
//  Created by saki on 2024/08/29.
//

import Foundation
import Combine
import Alamofire
typealias ResultHandler<T> = (Result<T, APIError>) -> Void

struct APIClient {
    private let url = NetworkConstants.baseURL    
    
    func request(handler: @escaping ResultHandler<Data>, users: User) {
        let urlString = String(url+"users")
        let url = URL(string: urlString)
        guard let url = URL(string: urlString) else {
            handler(.failure(.invalidURL))
            return
        }
        let param: Parameters = users.toParameters()
        let headers: HTTPHeaders = [
            "Content-Type":"application/json"
        ]
        AF.request(urlString, 
                   method: .post,
                   parameters: param,
                   encoding: JSONEncoding.default
        )
        .responseData { response in
            if let statusCode = response.response?.statusCode {
                  print("Status Code: \(statusCode)")
              }
                       switch response.result {
                           
                           case .success(let data):
                           handler(.success(data))
                           case .failure(let error):
                           handler(.failure(.invalidResponse(error)))
                       }
                   }
    }
}


enum APIError: Error {
    case invalidURL
    case invalidResponse(Error)
    case unknown(Error)
}

extension APIError {
    
    var title: String {
        switch self {
        case .invalidResponse(let error): return "無効なレスポンスです。\(error)"
        case .invalidURL: return "無効なURLです。"
        case .unknown(let error): return "予期せぬエラーが発生しました。\(error)"
        }
    }
    
}
