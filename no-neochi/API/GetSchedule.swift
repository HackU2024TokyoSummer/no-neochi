//
//  GetSchedule.swift
//  no-neochi
//
//  Created by saki on 2024/08/30.
//

import Alamofire
import Foundation

struct GetScedule {
    private let url = NetworkConstants.baseURL

    func request(handler: @escaping ResultHandler<[Schedule]>) {
        let urlString = String(url + "wakes")
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

                    // JSONDecoder を使ってデータをデコード
                    let decoder = JSONDecoder()

                    let dateFormatter = DateFormatter()
                    // ISO8601形式を指定
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

                    decoder.dateDecodingStrategy = .formatted(dateFormatter)
                    // ここで `Schedule` 型にデコード
                    let schedules = try decoder.decode([Schedule].self, from: data)

                    handler(.success(schedules))
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
