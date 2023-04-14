//
//  OnboardingLastPageView.swift
//  QuitHelper
//
//  Created by 이보한 on 2023/04/11.
//

import SwiftUI

struct OnboardingLastPageView: View {
    let imageName: String
    let title: String
    let subtitle: String
    
    @Binding var isFirstLaunching: Bool
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .padding()
            
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            Text(subtitle)
                .font(.title2)
            
            Button {
                isFirstLaunching.toggle()
            } label: {
                Text("기록 시작하기")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(Color.pink)
                    .cornerRadius(6)
            }
            .padding()
        }
    }
}
