//
//  GetSchedule.swift
//  no-neochi
//
//  Created by saki on 2024/08/30.
//

import Foundation
import Alamofire

struct GetScedule {
    private let url = NetworkConstants.baseURL
    
    func request(handler: @escaping ResultHandler<Schedule>) {
        let urlString = String(url+"wakes/create")
  
        
          AF.request(urlString,
                     method: .get,
                     encoding: URLEncoding.queryString)
          .responseData { response in
                     debugPrint(response)
                     
                     if let statusCode = response.response?.statusCode {
                         print("Status Code: \(statusCode)")
                     }
                     
                     switch response.result {
                     case .success(let data):
                         do {
                             // JSONDecoder を使ってデータをデコード
                             let decoder = JSONDecoder()
                             // ここで `Schedule` 型にデコード
                             let schedule = try decoder.decode(Schedule.self, from: data)
                             handler(.success(schedule))
                         } catch {
                             // デコードに失敗した場合
                             handler(.failure(.unknown(error)))
                         }
                     case .failure(let error):
                         handler(.failure(.unknown(error)))
                     }
                 }
             }
    }



