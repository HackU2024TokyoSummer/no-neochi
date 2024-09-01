//
//  LoginProtocol.swift
//  no-neochi
//
//  Created by saki on 2024/08/29.
//

import Alamofire
import Foundation

struct SignUp {
    private let url = NetworkConstants.baseURL

    func request(handler: @escaping ResultHandler<Data>, user: User) {
        let urlString = String(url + "users")

        let param: Parameters = user.toSignUpParameters()

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
