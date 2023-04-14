//
//  SettingsView.swift
//  QuitHelper
//
//  Created by 이보한 on 2023/03/31.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()

    var body: some View {
        NavigationView {
            Form{
                Section("흡연 비용") {
                    Stepper("한 갑당 가격: \(viewModel.pricePerPack)원", value: $viewModel.pricePerPack, in: 3000 ... 10000, step: 100)
                }
                
                Section("사고싶은 물건") {
                    TextField("이름", text: $viewModel.wishThing)
                    Stepper("가격: \(viewModel.wishThingPrice)만원", value: $viewModel.wishThingPrice, in: 0 ... 10000, step: 1)
                }
                
                Section("데이터 관리") {
                    NavigationLink("데이터", destination: CoreDataView())
                }
                
            }
            .navigationTitle("설정")
        }
    }
}


