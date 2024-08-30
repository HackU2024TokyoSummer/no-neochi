//
//  ContentView.swift
//  no-neochi
//
//  Created by saki on 2024/08/23.
//

import SwiftUI
import HealthKit

struct ScheduleListView: View {
  
    @State var isAddEvent = false
    @State var isCredit = false
 
    @State var schedules = [Schedule]()
    var body: some View {
        NavigationStack {
            ZStack {
                List(schedules) { schedule in
                    ScheduleRow(schedule: schedule)
                        .listRowSeparator(.hidden)
                    
                    
                }
                .padding(.horizontal, 28)
                .padding(.top, 20)
                .listStyle(PlainListStyle())
                .refreshable {
                    getAllScedule()
                }
                .toolbar {
                    ToolbarItem {
                        Button(
                            action: {
                               isCredit = true
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
            .sheet(isPresented: $isAddEvent, onDismiss:{getAllScedule()}) {
                AddEventView()
                    .presentationDetents([.medium])
            }
            .fullScreenCover(isPresented: $isCredit) {
               ContentView()
            }
            .onAppear(){
                getAllScedule()
                
                if(schedules != []){
                    
               
                CheckNeochi().checkPermistion()
                if let rootVC = UIApplication.shared.windows.first?.rootViewController {
                    CheckNeochi().setObserver(in: rootVC)
                 //   CheckNeochi().insertSampleData(in: rootVC)
                }
                
                }
             
            }
            
        }
    }
    func getAllScedule(){
        GetScedule().request(handler: {result in
            switch result{
            case .success(let data):
                schedules = data
                print(data)
                print("成功！")
            case.failure(let error):
                print("失敗！,",error)
            }})
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
            Text(formatter.formatDate(schedule.wake_time))
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
