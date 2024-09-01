//
//  PostCard.swift
//  no-neochi
//
//  Created by saki on 2024/08/31.
//

import Alamofire
import Combine
import Foundation

struct PostCard {
    private let url = NetworkConstants.baseURL

    func request(handler: @escaping ResultHandler<()>) {
        let urlString = String(url + "card")
        let email = UserDefaults.standard.value(forKey: "email")
        let param: Parameters = [
            "token":
                "64353366383264373439383762656536373466653665323765646234616133393734616535623463666235333136383031323861346462393730363332336630"
        ]
        let emailParam: Parameters = email as! Parameters

        let params: Parameters = param.merging(emailParam) { (_, new) in new }
        print(params)
        AF.request(
            urlString,
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
