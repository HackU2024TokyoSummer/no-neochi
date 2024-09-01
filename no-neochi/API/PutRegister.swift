//
//  PutRegister.swift
//  no-neochi
//
//  Created by saki on 2024/08/31.
//

import Foundation
import Alamofire
struct PutRegister {
    private let url = NetworkConstants.baseURL
    func request(handler: @escaping (Result<Void, APIError>) -> Void,scedule: Schedule) {
        let urlString = String(url+"register")
     
      
        let param: Parameters = ["access_id":scedule.access_id,"order_id":scedule.order_id]
        
        AF.request(urlString,
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
                       } catch {
                           // デコードに失敗した場合
                           handler(.failure(.decodingError(error)))
                       }
                   case .failure(let error):
                       handler(.failure(.unknown(error)))
                   }
               }
    }
}
