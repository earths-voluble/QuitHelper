//
//  OnboardingPageView.swift
//  QuitHelper
//
//  Created by 이보한 on 2023/04/11.
//

import SwiftUI

struct OnboardingPageView: View {
    let imageName: String
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            Text(subtitle)
                .font(.title2)
            
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 500, height: 500)
                .padding()
        }
    }
}
