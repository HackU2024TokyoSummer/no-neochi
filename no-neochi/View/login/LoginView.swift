//
//  LoginView.swift
//  no-neochi
//
//  Created by saki on 2024/08/25.
//

import SwiftUI

struct LoginView: View {
    @State var isSignUp = false
    @State var isLogin = false
    var body: some View {
        VStack {
            Button(
                action:  {
                    isSignUp = true
                } ,
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
                action:  {
                    isLogin = true
                } ,
                label: {
                    Text("Login")
                        .padding(10)
                        .foregroundStyle(Color.white)
                    
                        .padding(.horizontal, 60)
                        .background(Color.main)
                        .cornerRadius(10)
                    
                })
        }
        .fullScreenCover(isPresented: $isLogin, content: {
            LoginTextView()
        })
        .fullScreenCover(isPresented: $isSignUp, content: {
            SignTextView()
        })
    }
}

#Preview {
    LoginView()
}
