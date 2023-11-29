//
//  PlantListView.swift
//  PlantsApp
//
//  Created by Baris Dilekci on 25.11.2023.
//

import SwiftUI

struct PlantList: View {
    
    //MARK: - PROPERTIES
    @Environment(\.modelContext) private var modelContext
    let plants: [Item]
    
    
    //MARK: - BODY
    var body: some View {
            List {
                ForEach(plants) { plant in
                    NavigationLink(destination: PlantDetailView(plant: plant, plantsList: plants)) {
                        HStack(alignment: .top, spacing: 10) {
                            // Display the plant image using AsyncImage
                            AsyncImage(url: plant.getImageURL()) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 100) // Adjust the size as needed
                                    .clipShape(RoundedRectangle(cornerRadius: 7))
                                    .overlay(RoundedRectangle(cornerRadius: 7).stroke(Color.gray, lineWidth: 1))
                            } placeholder: {
                                // Placeholder view while loading
                                ProgressView()
                                    .frame(width: 100, height: 100)
                                    .background(Color.gray)
                                    .clipShape(RoundedRectangle(cornerRadius: 7))
                                    .overlay(RoundedRectangle(cornerRadius: 7).stroke(Color.gray, lineWidth: 1))
                            }
                            
                            .frame(width: 80,height: 80, alignment: .center)
                            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 3, x: 2, y: 2)
                            .cornerRadius(8)
                            
                            // Plant information
                            VStack(alignment: .leading, spacing: 5) {
                                Text(plant.name)
                                    .font(.title2)
                                    .foregroundColor(.black)
                                    .lineLimit(1)
                                
                                Text(plant.desc)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .lineLimit(2)
                                    .padding(.trailing, 10)
                            } //: VSTACK
                        } //: HSTACK
                    }
                } //: FOREACH
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Bitkilerim")

    }

    
    
    //MARK: - DELETE ITEMS
    private func deleteItems(indexSet: IndexSet) {
        indexSet.forEach { index in
            let plants = plants[index]
            modelContext.delete(plants)
            
            do {
                try modelContext.save()
                print("veri silindi")
            } catch {
                print(error.localizedDescription)
            }
            
        }
    }
}

#Preview {
    PlantList(plants: [])
        .modelContainer(for: [Item.self])
}
