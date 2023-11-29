//
//  PlantListView.swift
//  PlantsApp
//
//  Created by Baris Dilekci on 25.11.2023.
//

import SwiftUI
import SwiftData

struct PlantListView: View {
    @Query(sort: \Item.name, order: .forward) private var plants: [Item]
    @State  var isAddPlantPresented: Bool = false
    @State private var plantss : Item?
    
    var body: some View {
        
           PlantList(plants: plants)
               .toolbar(content: {
               ToolbarItem(placement: .topBarTrailing) {
                   Button("Bitki Ekle".localized()) {
                       isAddPlantPresented = true
                   }
                 

               }
           })
           .sheet(isPresented: $isAddPlantPresented, content: {
               NavigationStack {
                   AddPlantView()
               }
           })
       }
}

#Preview {
    PlantListView()
        .modelContainer(for: [Item.self])
}
