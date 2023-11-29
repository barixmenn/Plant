//
//  PlantHeader.swift
//  PlantsApp
//
//  Created by Baris Dilekci on 27.11.2023.
//

import SwiftUI

struct PlantHeader: View {
    var plant: Item
    
    @State private var isAnimatingImage: Bool = false

    var body: some View {
            VStack {
                AsyncImage(url: plant.getImageURL()) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: 350, maxHeight: 350)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 7))
                        .overlay(RoundedRectangle(cornerRadius: 7).stroke(Color.white, lineWidth: 2))
                } placeholder: {
                    // Placeholder view while loading
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.gray)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray, lineWidth: 1))
                }
                .scaleEffect(isAnimatingImage ? 1.0 : 0.8)
            }
            .onAppear() {
                withAnimation(.easeOut(duration: 0.5)) {
                    isAnimatingImage = true
                }
            }
        }
    
}
