//
//  FincodeService.swift
//  no-neochi
//
//  Created by saki on 2024/08/31.
//

import Foundation
import Combine
class FincodeService: ObservableObject {
    private let fincodeApiKey = "p_test_OTAzYmJiNjAtYjdjYy00NTZlLTg0NGYtMmZhOTBhYWQxZWFkMjI4MGNlMjAtZmEyYS00ZGQxLWI4MzMtNDJhNmY4N2M0YTc4c18yNDA4Mjg4Nzg4Mg"
    private let fincodeApiUrl = "https://api.test.fincode.jp/v1/tokens"

    func createToken(cardInfo: CardInfo) -> AnyPublisher<FincodeToken, Error> {

          var request = URLRequest(url: URL(string: fincodeApiUrl)!)
          request.httpMethod = "POST"
          request.addValue("application/json;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(fincodeApiKey)", forHTTPHeaderField: "Authorization")
    

          
          let body: [String: Any] = [
              "card_number": cardInfo.cardNumber,
              "security_code": cardInfo.securityCode,
              "expire_month": String(cardInfo.cardExpiry.prefix(2)),
              "expire_year": "20" + String(cardInfo.cardExpiry.suffix(2))
          ]
          
          request.httpBody = try? JSONSerialization.data(withJSONObject: body)
          
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .handleEvents(receiveOutput: { data in
                print("Raw data received: \(String(data: data, encoding: .utf8) ?? "No data")")
            })
            .decode(type: FincodeToken.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
      }
}
