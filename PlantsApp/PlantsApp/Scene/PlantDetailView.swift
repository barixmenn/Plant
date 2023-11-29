//
//  PlantDetailView.swift
//  PlantsApp
//
//  Created by Baris Dilekci on 27.11.2023.
//

import SwiftUI

struct PlantDetailView: View {
    // MARK: - PROPERTIES
    
    var plant: Item
    var plantsList : [Item]
    
    // MARK: - BODY
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack{
                    VStack(alignment: .leading) {
                        // HEADER
                        PlantHeader(plant: plant)
                        
                        VStack(alignment: .leading) {
                            // TITLE
                            Text(plant.name)
                                .font(.title2)
                            //.fontWeight(.semibold)
                            
                            
                            // HEADLINE
                            Text(plant.desc)
                                .font(.subheadline)
                                .multilineTextAlignment(.leading)
                        } //: VSTACK
                        .padding()
                    } //: VSTACK
                    .navigationBarHidden(true)
                    
                    Divider()
                    
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Bitkilerim".localized())
                            .padding(.leading)
                        
                        
                        // Diğer görünümler
                        
                        
                        ScrollView(.horizontal) {
                            
                            HStack(alignment: .center) {
                                ForEach(plantsList) { plants  in
                                    VStack(alignment: .leading) {
                                        
                                        AsyncImage(url: plants.getImageURL()) { image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(maxWidth: 150, maxHeight: 100)
                                                .clipped()
                                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                                .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.white, lineWidth: 2))
                                        } placeholder: {
                                            // Placeholder view while loading
                                            ProgressView()
                                                .frame(maxWidth: 100, maxHeight: 100)
                                                .background(Color.gray)
                                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                                .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray, lineWidth: 1))
                                        }
                                        
                                        Text(plants.name)
                                            .font(.headline)
                                        
                                    }
                                }
                            }
                            .padding(10)
                            
                        }
                        
                    }
                    
                } //: VSTACK
            } //: NAVIGATION
        }
        .padding(20)
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationTitle(plant.name)
       
    }
}

// MARK: - PREVIEW

//struct PlantDetailView: PreviewProvider {
//  static var previews: some View {
//      PlantDetailView(plant: [Item.self])
//  }
//}
