//
//  GetHistory.swift
//  no-neochi
//
//  Created by saki on 2024/08/30.
//

import Alamofire
import Foundation

struct GetHistory {
    private let url = NetworkConstants.baseURL
    func request(handler: @escaping ResultHandler<HistoryResponse>) {
        let urlString = String(url + "pastwakes")
        let email = UserDefaults.standard.value(forKey: "email")

        let param: Parameters = email as! Parameters

        AF.request(
            urlString,
            method: .get,
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
                    let decoder = JSONDecoder()

                    let dateFormatter = DateFormatter()

                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                    dateFormatter.locale = Locale(identifier: "ja_JP")
                    dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
                    decoder.dateDecodingStrategy = .formatted(dateFormatter)
                    // ここで `Schedule` 型にデコード
                    let history = try decoder.decode(HistoryResponse.self, from: data)

                    handler(.success(history))
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
