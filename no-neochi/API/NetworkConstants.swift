//
//  NetworkConstants.swift
//  no-neochi
//
//  Created by saki on 2024/08/29.
//

import Foundation
typealias ResultHandler<T> = (Result<T, APIError>) -> Void
class NetworkConstants: NSObject {

  // MARK: - Variables

  static var baseURL: String = {
    return "https://neoti-api-668f813a2c04.herokuapp.com/"
  }()

}
