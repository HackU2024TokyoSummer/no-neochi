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
    @State var isLogin = false
    @State var isShowAlert = false
    @State var selectedMoney = 100
    @State var moneys = [100, 500, 1000, 5000, 10000]

    var body: some View {
        VStack {
            Text("Email")
                .font(.custom("ABeeZee Regular", size: 14))
                .frame(maxWidth: .infinity, alignment: .leading)

            TextField("メールアドレスを入力", text: $email)

                .font(.system(size: 12))
                .padding(.vertical, 10)
                .padding(.horizontal, 10)
                .overlay(

                    RoundedRectangle(cornerRadius: 3)
                        .stroke(
                            Color(
                                #colorLiteral(
                                    red: 0.886274516582489, green: 0.7764706015586853, blue: 1,
                                    alpha: 1)), lineWidth: 1)
                )

                .padding(.bottom, 35)
            Text("Password")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.custom("ABeeZee Regular", size: 14))

            TextField("パスワードを入力", text: $password)
                .font(.system(size: 12))
                .padding(.vertical, 10)
                .padding(.horizontal, 10)
                .overlay(

                    RoundedRectangle(cornerRadius: 3)
                        .stroke(
                            Color(
                                #colorLiteral(
                                    red: 0.886274516582489, green: 0.7764706015586853, blue: 1,
                                    alpha: 1)), lineWidth: 1)
                )

                .padding(.bottom, 35)
            //Password
            Text("Password(confirm)")
                .font(.custom("ABeeZee Regular", size: 14))
                .frame(maxWidth: .infinity, alignment: .leading)

            TextField("もう一度パスワードを入力", text: $conirmPassword)
                .font(.system(size: 12))
                .padding(.vertical, 10)
                .padding(.horizontal, 10)
                .overlay(

                    RoundedRectangle(cornerRadius: 3)
                        .stroke(
                            Color(
                                #colorLiteral(
                                    red: 0.886274516582489, green: 0.7764706015586853, blue: 1,
                                    alpha: 1)), lineWidth: 1)
                )

                .padding(.bottom, 35)

            //Name
            Text("Name")
                .font(.custom("ABeeZee Regular", size: 14))
                .frame(maxWidth: .infinity, alignment: .leading)

            TextField("名前を入力", text: $name)
                .font(.system(size: 12))
                .padding(.vertical, 10)
                .padding(.horizontal, 10)
                .overlay(

                    RoundedRectangle(cornerRadius: 3)
                        .stroke(
                            Color(
                                #colorLiteral(
                                    red: 0.886274516582489, green: 0.7764706015586853, blue: 1,
                                    alpha: 1)), lineWidth: 1)
                )
                .padding(.bottom, 35)
            Text("最大課金額")
                .font(.custom("ABeeZee Regular", size: 14))
                .frame(maxWidth: .infinity, alignment: .leading)

            Picker("", selection: $selectedMoney) {
                ForEach(moneys, id: \.self) { money in

                    Text("\(money)円")
                }

            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .onAppear {
                print(moneys)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 10)
            .overlay(

                RoundedRectangle(cornerRadius: 3)
                    .stroke(
                        Color(
                            #colorLiteral(
                                red: 0.886274516582489, green: 0.7764706015586853, blue: 1, alpha: 1
                            )), lineWidth: 1)
            )
            .padding(.bottom, 35)

            Button(
                action: {
                    UserDefaults.standard.set(["email": email], forKey: "email")
                    UserDefaults.standard.set(selectedMoney, forKey: "maxBilling")
                    let user: User = User(name: name, email: email, password: password)
                    SignUp().request(
                        handler: { result in
                            switch result {
                            case .success(let data):
                                print("成功！", data)
                                PostCustomer().request(
                                    handler: { result in
                                        switch result {
                                        case .success():
                                            print("customer成功！")
                                            isLogin = true
                                        case .failure(let error):
                                            print("customerエラー！", error)
                                        }
                                    }, user: user)

                            case .failure(let error):
                                print("失敗！", error)
                            }
                        }, user: user)
                },
                label: {
                    Text("Sign Up")
                        .font(.custom("ABeeZee Regular", size: 14)).foregroundColor(
                            Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
                        ).multilineTextAlignment(.center)
                        .padding(.horizontal, 78)
                        .padding(.vertical, 10)
                        .background(
                            Color(
                                #colorLiteral(
                                    red: 0.886274516582489, green: 0.7764706015586853, blue: 1,
                                    alpha: 1))
                        )
                        .cornerRadius(10)

                })
        }
        .padding(.horizontal, 57)
        .fullScreenCover(
            isPresented: $isLogin,
            content: {
                ButtomNavigationView()
            })

    }
}

#Preview {
    SignTextView()
}
