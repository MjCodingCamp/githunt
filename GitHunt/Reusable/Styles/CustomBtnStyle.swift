//
//  CommonBtn.swift
//  GitHunt
//
//  Created by Mohammad Jeeshan on 14/10/23.
//

import SwiftUI

struct CustomBtnStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            .font(.system(size: 20, weight: .medium))
            .foregroundColor(Color.black)
            .background(ColorConstant.secondaryColor)
            .cornerRadius(6)
    }
}
