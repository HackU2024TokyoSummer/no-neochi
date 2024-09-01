//
//  AddEventView.swift
//  no-neochi
//
//  Created by saki on 2024/08/25.
//

import SwiftUI

struct AddEventView: View {
    @State var date = Date()
    @State var selectedMoney = 100
    @State var formatter = Formatter()
    @State var moneys = 50.0
    @State var isAlert = false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("時間")
                        .padding(.trailing, 25)
                    DatePicker("日付を選択", selection: $date,  in: Date()...)
                        .labelsHidden()
                        .datePickerStyle(DefaultDatePickerStyle())
                    Spacer()
                    
                }
                .frame(width: 300)
                .padding(.horizontal, 17)
                .padding(.vertical, 10)
                .border(Color.main)
                
                HStack {
                    Text("起きたい度")
                    
                    Slider(value: $moneys,
                           in: 0...100)
                    .tint(Color.main)
                    
                    
                    Spacer()
                }
                .frame(width: 300)
                .padding(.horizontal, 17)
                .padding(.vertical, 10)
                .border(Color.main)
                .padding(.vertical, 10)
                
            }
            
            .navigationTitle("予定追加")
            .toolbar {
                Button(
                    action: {
                        
                        let maxBilling =   UserDefaults.standard.value(forKey: "maxBilling")
                        let billing = maxBilling as! Double * (moneys/100)
                        if (billing >= 1000){
                            isAlert = true
                            
                        }else{
                            let schedule = Schedule(wake_time: date, billing: Int(billing),access_id: "", order_id: "")
                            CreateScedule().request(handler: {result  in
                                switch result {
                                case .success(let data):
                                    print("成功！")
                                    
                                case .failure(let error):
                                    print("失敗！",error)
                                }
                            }, schedule: schedule)
                            
                            dismiss()
                        }
                    },
                    label: {
                        Text("登録")
                    })
            }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    
                    Button(
                        action: {
                            dismiss()
                        },
                        label: {
                            Text("戻る")
                        })
                }
            }
            .alert("", isPresented: $isAlert){
                Button(action: {
                    let maxBilling =   UserDefaults.standard.value(forKey: "maxBilling")
                    let billing = maxBilling as! Double * (moneys/100)
                    
                    let schedule = Schedule(wake_time: date, billing: Int(billing),access_id: "", order_id: "")
                    CreateScedule().request(handler: {result  in
                        switch result {
                        case .success(let data):
                            print("成功！")
                            
                        case .failure(let error):
                            print("失敗！",error)
                        }
                    }, schedule: schedule)
                    dismiss()
                    
                }, label: {
                    
                    
                    Text("はい")
                    
                    
                    
                })
                
            } message: {
                Text("1000円を超えますが本当にいいですか？")
            }
        }
    }
}


#Preview {
    AddEventView()
}
