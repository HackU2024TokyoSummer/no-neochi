//
//  Login.swift
//  no-neochi
//
//  Created by saki on 2024/08/29.
//

import Alamofire
import Combine
import Foundation

struct Login {
    private let url = NetworkConstants.baseURL

    func request(handler: @escaping ResultHandler<Data>, user: User) {
        let urlString = String(url + "login")

        let param: Parameters = user.toLoginParameters()

        AF.request(
            urlString,
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
