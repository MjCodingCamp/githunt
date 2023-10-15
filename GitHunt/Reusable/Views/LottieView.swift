//
//  LottieView.swift
//  GitHunt
//
//  Created by Mohammad Jeeshan on 14/10/23.
//

import SwiftUI
import Lottie

 
struct LottieView: UIViewRepresentable {
    let animationView: LottieAnimationView

    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        view.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // MARK: update 
    }

    func playAnimation(){
        animationView.play()
    }
    func stopAnimation(){
        animationView.stop()
    }
}
