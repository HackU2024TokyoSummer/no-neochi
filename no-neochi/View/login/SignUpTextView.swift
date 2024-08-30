//
//  LoginTextView.swift
//  no-neochi
//
//  Created by saki on 2024/08/29.
//

import SwiftUI

struct SignTextView: View {
    @State var email = ""
    @State var password = ""
    @State var conirmPassword = ""
    @State var name = ""
    var body: some View {
        VStack{
            Text("Email")
                .font(.custom("ABeeZee Regular", size: 14))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            
            TextField("", text: $email)
                .border(Color(#colorLiteral(red: 0.886274516582489, green: 0.7764706015586853, blue: 1, alpha: 1)))
                .font(.system(size: 30))
            
            
                .padding(.bottom, 35)
            Text("Password")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.custom("ABeeZee Regular", size: 14))
            
            
            
            TextField("", text: $password)
                .border(Color(#colorLiteral(red: 0.886274516582489, green: 0.7764706015586853, blue: 1, alpha: 1)))
                .font(.system(size: 30))
            
            
                .padding(.bottom, 35)
            //Password
            Text("Password(confirm)")
                .font(.custom("ABeeZee Regular", size: 14))
                .frame(maxWidth: .infinity, alignment: .leading)
    
            TextField("", text: $conirmPassword)
                .border(Color(#colorLiteral(red: 0.886274516582489, green: 0.7764706015586853, blue: 1, alpha: 1)))
                .font(.system(size: 30))
            
            
                .padding(.bottom, 35)
            
            //Name
            Text("Name")
                .font(.custom("ABeeZee Regular", size: 14))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField("", text: $name)
                .border(Color(#colorLiteral(red: 0.886274516582489, green: 0.7764706015586853, blue: 1, alpha: 1)))
                .font(.system(size: 30))
                .padding(.bottom, 35)
            

            Button(action: {
                let user: User = User(name: name, email: email, password: password)
                SignUp().request(handler: {result in
                    switch result {
                    case .success(let user):
                        print("成功！",user)
                    case.failure(let error):
                        print("失敗！",error)
                    }
                }, users: user)
            }, label: {
                Text("Sign Up").font(.custom("ABeeZee Regular", size: 14)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).multilineTextAlignment(.center)
                    .padding(.horizontal,78)
                    .padding(.vertical, 10)
                    .background(Color(#colorLiteral(red: 0.886274516582489, green: 0.7764706015586853, blue: 1, alpha: 1)))
                    .cornerRadius(10)
                
                
            })
        }
        .padding(.horizontal,57)
        
        
    }
}

#Preview {
    SignTextView()
}
