//
//  LoginTextView.swift
//  no-neochi
//
//  Created by saki on 2024/08/30.
//


import SwiftUI

struct LoginTextView: View {
    @State var email = ""
    @State var password = ""
    @State var conirmPassword = ""
    @State var name = ""
    @State var isLogin = false
    var body: some View {
        VStack{
            Text("Email")
                .font(.custom("ABeeZee Regular", size: 14))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            
            TextField("メールアドレスを入力", text: $email)
                .font(.system(size: 12))
                .padding(.vertical,10)
                .padding(.horizontal, 10)
                         .overlay(
                            
                             RoundedRectangle(cornerRadius: 3)
                                .stroke(Color(#colorLiteral(red: 0.886274516582489, green: 0.7764706015586853, blue: 1, alpha: 1)), lineWidth: 1)
                         )
            
                .padding(.bottom, 35)
            Text("Password")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.custom("ABeeZee Regular", size: 14))
            
            
            
            TextField("パスワードを入力", text: $password)
                .font(.system(size: 12))
                .padding(.vertical,10)
                .padding(.horizontal, 10)
                         .overlay(
                            
                             RoundedRectangle(cornerRadius: 3)
                                .stroke(Color(#colorLiteral(red: 0.886274516582489, green: 0.7764706015586853, blue: 1, alpha: 1)), lineWidth: 1)
                         )
            
            
                .padding(.bottom, 35)
         

            Button(action: {
                UserDefaults.standard.set(["email": email], forKey: "email")
                UserDefaults.standard.set(10000, forKey: "maxBilling")
                let user: User = User(name: name, email: email, password: password)
               Login().request(handler: {result in
                    switch result {
                    case .success(let user):
                        print("成功！")
                        isLogin = true
                    case.failure(let error):
                        print("失敗！",error)
                    }
                }, user: user)
            }, label: {
                Text("Login")
                    .font(.custom("ABeeZee Regular", size: 14))
                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    .padding(.horizontal,78)
                    .padding(.vertical, 10)
                    .background(Color(#colorLiteral(red: 0.886274516582489, green: 0.7764706015586853, blue: 1, alpha: 1)))
                    .cornerRadius(10)
                
                
            })
        }
        .padding(.horizontal,57)
        .fullScreenCover(isPresented: $isLogin, content: {
            ButtomNavigationView()
        })
        
        
    }
}

#Preview {
    LoginTextView()
}
