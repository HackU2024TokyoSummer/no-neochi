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
    case decodingError(Error)
    case unknown(Error)
}

extension APIError {
    
    var title: String {
        switch self {
        case .invalidResponse(let error): return "無効なレスポンスです。\(error)"
        case .invalidURL: return "無効なURLです。"
        case .decodingError(let error): return "デコード失敗しました\(error)"
        case .unknown(let error): return "予期せぬエラーが発生しました。\(error)"
        }
    }
    
}
