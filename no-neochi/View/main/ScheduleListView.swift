//
//  ContentView.swift
//  no-neochi
//
//  Created by saki on 2024/08/23.
//

import SwiftUI
import HealthKit

struct ScheduleListView: View {
    let sampleSchedules = [
        
        Schedule(id: 0, date: Date(), billing: 1000),
        Schedule(id: 1,
                 date: Date().addingTimeInterval(86400),
                 billing: 1500),
        Schedule(id: 2,
                 date: Date().addingTimeInterval(172800),
                 billing: 2000),
        
    ]
    @State var isAddEvent = false
    @State var isShowAlert = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                List(sampleSchedules) { schedule in
                    ScheduleRow(schedule: schedule)
                        .listRowSeparator(.hidden)
                    
                    
                }
                .padding(.horizontal, 28)
                .padding(.top, 20)
                .listStyle(PlainListStyle())
                .toolbar {
                    ToolbarItem {
                        Button(
                            action: {
                                
                            },
                            label: {
                                Image(systemName: "person.circle")
                                    .foregroundColor(Color.button)
                            })
                    }
                }
                .toolbarBackground(Color.main.opacity(0.5), for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .navigationTitle("予定")
                .navigationBarTitleDisplayMode(.inline)
                
                Button(
                    action: {
                        isAddEvent.toggle()
                    },
                    label: {
                        Image(systemName: "plus")
                            .resizable()
                            .foregroundStyle(Color.white)
                        
                            .padding(.all, 20)
                            .background(Color.main)
                            .cornerRadius(40)
                            .frame(width: 60, height: 60, alignment: .bottomLeading)
                    }
                )
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .bottomTrailing
                )
                .padding(.trailing, 30)
            }
            .sheet(isPresented: $isAddEvent) {
                AddEventView()
                    .presentationDetents([.medium])
            }
            .onAppear(){
                CheckNeochi().checkPermistion()
                CheckNeochi().setObserver()
                GetScedule().request(handler: {result in
                    switch result{
                    case .success(let data):
                        print("成功！")
                    case.failure(let error):
                        print("失敗！",error)
                    }})
                
            }
            .alert("ねました！", isPresented: $isShowAlert) {
                //ここで課金
                
            } message: {
                // アラートのメッセージ...
                Text("あなたは課金されます")
            }
        }
    }
}

#Preview {
    ScheduleListView()
}

struct ScheduleRow: View {
    let schedule: Schedule
    @State var formatter = Formatter()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(formatter.formatDate(schedule.date))
                .font(.system(size: 16))
                .padding(.vertical, 6)
            HStack {
                
                
                Text("¥\(schedule.billing)")
                    .padding(.leading, 116)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.vertical, 20)
        .padding(.horizontal, 30)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.main, lineWidth: 1)
        )
        
        
    }
    
}
