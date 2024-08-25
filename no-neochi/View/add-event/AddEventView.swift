//
//  AddEventView.swift
//  no-neochi
//
//  Created by saki on 2024/08/25.
//

import SwiftUI

struct AddEventView: View {
    @State var date  = Date()
    @State var time = Date()
    @State var selectedMoney = "100"
    @State var formatter = Formatter()
    @State var moneys = ["100","500","1,000","5000","10,000"]
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading){
                HStack{
                    Text("日付")
                        .padding(.trailing, 25)
                    DatePicker("日付を選択", selection: $date, displayedComponents: .date)
                        .labelsHidden()
                        .datePickerStyle(DefaultDatePickerStyle())
                    
                    Spacer()
                }
                .frame(width: 300)
                .padding(.horizontal,17)
                .padding(.vertical,10)
                .border(Color.main)
                
                .padding(.vertical, 10)
                HStack{
                    Text("時間")
                        .padding(.trailing, 25)
                    DatePicker("日付を選択", selection: $date, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(DefaultDatePickerStyle())
                    Spacer()
                    
                }
                .frame(width: 300)
                .padding(.horizontal,17)
                .padding(.vertical,10)
                .border(Color.main)
                
                HStack{
                    Text("課金額")
                    
                    Picker("", selection: $selectedMoney) {
                        ForEach(moneys, id: \.self){ money in
                            Text("\(money)円")
                        }
                        
                    }
                    Spacer()
                }
                .frame(width: 300)
                .padding(.horizontal,17)
                .padding(.vertical,10)
                .border(Color.main)
                .padding(.vertical, 10)
                
            }
            
            .navigationTitle("予定追加")
            .toolbar(){
                Button(action: {
                    //保存
                }, label: {
                    Text("登録")
                })
            }
            
            .toolbar(){
                ToolbarItem(placement: .navigationBarLeading){
                    
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("戻る")
                    })
                }
            }
        }
    }
}

#Preview {
    AddEventView()
}
