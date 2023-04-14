//
//  OnboardingTabView.swift
//  QuitHelper
//
//  Created by 이보한 on 2023/04/11.
//

import SwiftUI

struct OnboardingTabView: View {
    @Binding var isFirstLaunching: Bool
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        TabView {
            
            OnboardingPageView(imageName: "OnboardingMain", title: "심플한 흡연 기록 도우미", subtitle: "메인화면에서 손쉽게 기록하세요")
                
            OnboardingPageView(imageName: "OnboardingStatus", title: "흡연으로 낭비되는 지출", subtitle: "한눈에 알아보세요")
            
            OnboardingPageView(imageName: "OnboardingSettings", title: "간편하게 설정하세요", subtitle: "자동으로 통계를 내드려요")
            
            OnboardingLastPageView(imageName: "IconWithoutBoundary", title: "QuitHelper와 함께", subtitle: "금연을 성공하는 그날까지!", isFirstLaunching: $isFirstLaunching)
            
        }
        .tabViewStyle(PageTabViewStyle())
        .onAppear {
                if colorScheme == .light {
                    UIPageControl.appearance().currentPageIndicatorTintColor = .black
                    UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
                } else {
                    UIPageControl.appearance().currentPageIndicatorTintColor = .white
                    UIPageControl.appearance().pageIndicatorTintColor = UIColor.white.withAlphaComponent(0.2)
                }
            }
    }
}
