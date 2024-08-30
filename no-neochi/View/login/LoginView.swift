//
//  LoginView.swift
//  no-neochi
//
//  Created by saki on 2024/08/25.
//

import SwiftUI

struct LoginView: View {
    
    var body: some View {
        VStack {
            Button(
                action: /*@START_MENU_TOKEN@*/ {} /*@END_MENU_TOKEN@*/,
                label: {
                    Text("Sign-up")
                        .padding(10)

                        .foregroundStyle(Color.white)

                        .padding(.horizontal, 50)
                        .background(Color.main)
                        .cornerRadius(10)

                }
            )
            .padding(.bottom, 61)
            Button(
                action: /*@START_MENU_TOKEN@*/ {} /*@END_MENU_TOKEN@*/,
                label: {
                    Text("Login")
                        .padding(10)

                        .foregroundStyle(Color.white)

                        .padding(.horizontal, 60)
                        .background(Color.main)
                        .cornerRadius(10)

                })
        }
    }
}

#Preview {
    LoginView()
}
