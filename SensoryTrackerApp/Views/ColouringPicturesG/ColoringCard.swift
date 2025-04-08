//
//  ColoringCard.swift
//  SensoryTrackerApp
//
//  Created by Александра Тажибай on 07.04.2025.
//

import SwiftUI

struct ColoringCard: View {
    let model: ColoringCardModel

    var body: some View {
        VStack {
            Image(model.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 120)
                .cornerRadius(10)
            Button(action: {
                withAnimation {
                 }
            }) {
                Text("Start")
                    .font(.title3)
                    .padding(10)
                    .padding(.horizontal, 5)
                    .background(Color(red: 0.11, green: 0.71, blue: 1.0))
                    .cornerRadius(20)
            }
            .font(.subheadline)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 3)
    }
}
