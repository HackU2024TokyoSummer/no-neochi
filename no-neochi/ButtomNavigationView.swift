//
//  ButtomNavigationView.swift
//  no-neochi
//
//  Created by saki on 2024/08/24.
//

import SwiftUI

struct ButtomNavigationView: View {
    var body: some View {
        TabView {
            ScheduleListView()
                .tabItem {
                    Image("calendar")
                }
           HistoryView()
                .tabItem {
                    Image("time")
                }
        }
       
    }
        
}

#Preview {
    ButtomNavigationView()
}
