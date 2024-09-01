//
//  HistoryView.swift
//  no-neochi
//
//  Created by saki on 2024/08/30.
//

import SwiftUI

struct HistoryView: View {
    @State var totalBilling = 0
    @State var histories = [History]()

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("今までの課金額")
                        .padding(.trailing, 50)
                    Text("\(totalBilling)円")
                        .bold()

                }
                .padding(.vertical, 30)
                .padding(.horizontal, 22)
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.main, lineWidth: 1)
                        .shadow(color: Color.main, radius: 5, x: 0, y: 1)
                )

                .padding(.bottom, 40)
                List(histories) { history in
                    VStack {
                        HStack {
                            Text(Formatter().formatHistoryDate(history.wake_time))
                            Spacer()
                            Text("\(history.billing)円")

                        }
                    }
                    .listRowSeparatorTint(Color.main)

                }
                .listStyle(PlainListStyle())
                .toolbarBackground(Color.main.opacity(0.5), for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .navigationTitle("履歴")
                .navigationBarTitleDisplayMode(.inline)

            }
            .padding(.top, 20)
            .padding(.horizontal, 25)
            .onAppear {
                GetHistory().request { result in
                    switch result {
                    case .success(let data):
                        print("履歴取得できたよ")

                        histories = data.history
                        totalBilling = data.total_money
                    case .failure(let error):
                        print("履歴取得失敗", error)
                    }
                }
            }

        }
    }
}

#Preview {
    HistoryView()
}
