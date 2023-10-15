//
//  CustomText.swift
//  GitHunt
//
//  Created by Mohammad Jeeshan on 14/10/23.
//

import SwiftUI

struct CustomTxtModifier: ViewModifier {
    let size: CGFloat
    let weight: Font.Weight
    let color: Color = Color.black
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: size, weight: weight))
            .foregroundColor(color)
            .transition(.scale)
    }
}
