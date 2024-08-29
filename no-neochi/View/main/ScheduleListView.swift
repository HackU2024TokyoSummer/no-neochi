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
        
        Schedule(date: Date(), time: Date(), billing: 1000),
        Schedule(
            date: Date().addingTimeInterval(86400), time: Date().addingTimeInterval(3600),
            billing: 1500),
        Schedule(
            date: Date().addingTimeInterval(172800), time: Date().addingTimeInterval(7200),
            billing: 2000),
        
    ]
    @State var isAddEvent = false
    
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
                Text(formatter.formatTime(schedule.time))
                
                Text("¥\(schedule.billing)")
                    .padding(.leading, 116)
            }
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 30)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.main, lineWidth: 1)
        )
        
    }
    
}
