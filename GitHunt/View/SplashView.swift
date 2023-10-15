//
//  Splash Screen.swift
//  GitHunt
//
//  Created by Mohammad Jeeshan on 14/10/23.
//

import SwiftUI
import Lottie

struct SplashView: View {
    @State private var showTitle = false
    @State private var isActive = false
    private let lottieView = LottieView(animationView: LottieAnimationView(name: StringConstant.logo))
    
    var body: some View {
        VStack {
            if (isActive) {
                HomeView()
            } else if (showTitle) {
                lottieView
                Text(StringConstant.splashTitle)
                    .modifier(CustomTxtModifier(size: 25, weight: .semibold))
            }
        }.onAppear() {
            lottieView.playAnimation()
            withAnimation {
                showTitle = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
               isActive = true
            })
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
