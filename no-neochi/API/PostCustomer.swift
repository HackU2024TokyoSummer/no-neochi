//
//  PostCustomer.swift
//  no-neochi
//
//  Created by saki on 2024/08/31.
//

import Foundation

import Combine
import Alamofire

struct PostCustomer {
    private let url = NetworkConstants.baseURL
    
    func request(handler: @escaping ResultHandler<()>, user: User) {
        let urlString = String(url+"customer")

        let param: Parameters = ["email":user.email]
        print(param)
        AF.request(urlString,
                   method: .post,
                   parameters: param,
                   encoding: URLEncoding.queryString
        )
        .responseData { response in
            if let statusCode = response.response?.statusCode {
                  print("Status Code: \(statusCode)")
              }
                       switch response.result {
                           case .success(let data):
                           handler(.success(()))
                           case .failure(let error):
                           handler(.failure(.invalidResponse(error)))
                       }
                   }
    }
}
