//
//  LoginModel.swift
//  no-neochi
//
//  Created by saki on 2024/08/30.
//

import Alamofire
import Foundation

struct User: Decodable {
    let name: String
    let email: String
    let password: String

}
extension User {
    func toSignUpParameters() -> [String: Any] {
        return [
            "user": [
                "name": self.name,
                "email": self.email,
                "password": self.password,
            ]
        ]

    }
    func toLoginParameters() -> [String: Any] {
        return [
            "user": [
                "email": self.email,
                "password": self.password,
            ]
        ]

    }
}
