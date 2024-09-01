//
//  ButtomNavigationView.swift
//  no-neochi
//
//  Created by saki on 2024/08/24.
//

import SwiftUI

struct ButtomNavigationView: View {
    enum Tab {
        case circle
        case triangle
    }
    /// 選択中のタブ
    @State private var selection: Tab = .circle

    var body: some View {
        TabView(selection: $selection) {

            ScheduleListView()
                .tabItem {
                    Image("calendar")
                        .renderingMode(.template)
                        .foregroundColor(selection == .circle ? Color.blue : Color.gray)
                }
            HistoryView()
                .tabItem {
                    Image("time")
                        .renderingMode(.template)
                        .foregroundColor(selection == .triangle ? Color.blue : Color.gray)
                }
        }

    }

}

#Preview {
    ButtomNavigationView()
}
