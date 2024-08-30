//
//  cradit.swift
//  no-neochi
//
//  Created by saki on 2024/08/31.
//

import Foundation
import SwiftUI
import Combine

struct CardInfo: Codable {
    let cardNumber: String
    let cardExpiry: String
    let securityCode: String
}

struct FincodeToken: Codable {
    let id: String
}



struct ContentView: View {
    @State private var cardNumber = ""
    @State private var cardExpiry = ""
    @State private var securityCode = ""
    @State private var message = ""
    @StateObject private var fincodeService = FincodeService()
    
    var body: some View {
        VStack {
            TextField("Card Number", text: $cardNumber)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Expiry (MM/YY)", text: $cardExpiry)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("CVC", text: $securityCode)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Process Payment") {
                let cardInfo = CardInfo(cardNumber: cardNumber, cardExpiry: cardExpiry, securityCode: securityCode)
                fincodeService.createToken(cardInfo: cardInfo)
                    .receive(on: DispatchQueue.main)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            break
                        case .failure(let error):
                           
                            message = "Error: \(error.localizedDescription)"
                            print(message)
                        }
                    }, receiveValue: { token in
                        sendTokenToRailsAPI(token: token.id)
                    })
                    .store(in: &cancellables)
            }
            
            Text(message)
        }
        .padding()
    }
    
@State var cancellables: Set<AnyCancellable> = []
    
    private func sendTokenToRailsAPI(token: String) {
        let railsApiUrl = "https://your-rails-api-url.com/api/v1/payments"
        var request = URLRequest(url: URL(string: railsApiUrl)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["token": token]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    message = "Error sending token to Rails API: \(error.localizedDescription)"
                }
            }, receiveValue: { data in
                do {
                    if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        message = "Payment processed: \(jsonObject)"
                    } else {
                        message = "Invalid response format"
                    }
                } catch {
                    message = "Error processing response: \(error.localizedDescription)"
                }
            })
            .store(in: &cancellables)
    }

}
