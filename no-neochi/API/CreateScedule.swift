//
//  CreateScedule.swift
//  no-neochi
//
//  Created by saki on 2024/08/30.
//

import Foundation
import Combine
import Alamofire

struct CreateScedule {
    private let url = NetworkConstants.baseURL
    
    func request(handler: @escaping ResultHandler<Data>, schedule: Schedule) {
        let urlString = String(url+"wakes/create")
        let email =   UserDefaults.standard.value(forKey: "email")as? [String: String]
      print(email)
        let emailParam: Parameters = email!
        
        let scheduleParam: Parameters = schedule.toCreateScheduleParameters()
      
        let params: Parameters = scheduleParam.merging(emailParam) { (_, new) in new }
     
        print(params)
          AF.request(urlString,
                     method: .post,
                     parameters: params,
                     encoding: URLEncoding.queryString)
        .responseData { response in
            if let statusCode = response.response?.statusCode {
                  print("Status Code: \(statusCode)")
              }
                       switch response.result {
                           case .success(let data):
                           handler(.success(data))
                           case .failure(let error):
                           handler(.failure(.unknown(error)))
                       }
                   }
    }
}


