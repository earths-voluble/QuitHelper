//
//  TabView.swift
//  QuitHelper
//
//  Created by 이보한 on 2023/03/29.
//

import SwiftUI

struct MainTabView: View {
    
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Image(systemName: "person")
                    Text("기록하기")
                }
            StatusView()
                .tabItem {
                    Image(systemName: "chart.bar")
                    Text("현황")

                }
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("설정")
                }
        }
    }
}
