//
//  ContentView.swift
//  QuitHelper
//
//  Created by 이보한 on 2023/03/28.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @AppStorage("pricePerPack") var pricePerPack: Int = 0
    @AppStorage("debugDate") var debugDate: Date = Date()
    @AppStorage("_isFirstLaunching") var isFirstLaunching: Bool = true
    @StateObject private var viewModel = ContentViewViewModel(viewContext: PersistenceController.shared.container.viewContext)
    
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        
        let costPerSmoke = pricePerPack / 20

        NavigationView {
            VStack {

                Spacer()
                Text("오늘의 흡연량: \(viewModel.todaySmoked / 20)갑 \(viewModel.todaySmoked % 20)개피")
                    .font(.system(size: 25, weight: .semibold))
                    .padding(.bottom)
                    .padding(.top)
                Text("\(Int(viewModel.todaySmoked) * costPerSmoke)원 어치")
                    .font(.system(size: 20))

                Spacer()

                ZStack {

                    Text("\(viewModel.cigarettes)")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top)
                    HStack {
                        Spacer()
                        mainButton(systemImageName: "minus", action: viewModel.decrementCigarettes)
                        Spacer()
                        Spacer()
                        mainButton(systemImageName: "plus", action: viewModel.incrementCigarettes)
                        Spacer()
                    }
                    .padding(.top)
                }
                HStack {

                    Spacer()

                    Button("추가") {
                        viewModel.addData()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.pink)
                    .disabled(viewModel.cigarettes == 0)

                    Spacer()

                    Button("지우기") {
                        viewModel.clearData()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.pink)
                    .disabled(viewModel.cigarettes == 0)

                    Spacer()

                }
                .padding()
                .frame(maxWidth: .infinity)

            }
            .navigationTitle("기록하기")
            .fullScreenCover(isPresented: $isFirstLaunching) {
                OnboardingTabView(isFirstLaunching: $isFirstLaunching)
            }
            

        }
    }
    
    func mainButton(systemImageName: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: systemImageName)
                .foregroundColor(.white)
                .frame(width: 90, height: 70)
                .background(Color.pink)
                .clipShape(Capsule())
                .shadow(color: colorScheme == .dark ? .clear : .gray, radius: 10, x: 0.0, y: 10)
        }
    }
}
