//
//  PutNeochi.swift
//  no-neochi
//
//  Created by saki on 2024/08/30.
//

import Alamofire
import Foundation

struct PutNeochi {
    private let url = NetworkConstants.baseURL
    func request(handler: @escaping (Result<Void, APIError>) -> Void) {
        let urlString = String(url + "neoti")
        let email = UserDefaults.standard.value(forKey: "email")

        let param: Parameters = email as! Parameters

        AF.request(
            urlString,
            method: .put,
            parameters: param,
            encoding: URLEncoding.queryString
        )
        .responseData { response in

            if let statusCode = response.response?.statusCode {
                print("Status Code: \(statusCode)")
            }

            switch response.result {
            case .success(let data):
                do {

                    handler(.success(()))
                }
                catch {
                    // デコードに失敗した場合
                    handler(.failure(.decodingError(error)))
                }
            case .failure(let error):
                handler(.failure(.unknown(error)))
            }
        }
    }
}
