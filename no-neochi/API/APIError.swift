//
//  APIError.swift
//  no-neochi
//
//  Created by saki on 2024/08/30.
//

import Foundation
enum APIError: Error {
    case invalidURL
    case invalidResponse(Error)
    case unknown(Error)
}

extension APIError {
    
    var title: String {
        switch self {
        case .invalidResponse(let error): return "無効なレスポンスです。\(error)"
        case .invalidURL: return "無効なURLです。"
        case .unknown(let error): return "予期せぬエラーが発生しました。\(error)"
        }
    }
    
}
