//
//  Item.swift
//  PlantsApp
//
//  Created by Baris Dilekci on 24.11.2023.
//

import Foundation
import SwiftData

@Model
final class Item {
        var name: String
        var timestamp : Date
        var desc : String
        var image: Data?
        
    init(name: String, timestamp: Date, desc: String, image: Data? = nil) {
        self.name = name
        self.timestamp = timestamp
        self.desc = desc
        self.image = image
    }
    
    
    // Convert Data to a temporary file URL
       func getImageURL() -> URL? {
           do {
               let temporaryFileURL = try FileManager.default
                   .url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                   .appendingPathComponent(UUID().uuidString)
                   .appendingPathExtension("jpg")

               // Write the image data to the temporary file
               try image?.write(to: temporaryFileURL)
               return temporaryFileURL
           } catch {
               print("Error creating temporary file URL: \(error)")
               return nil
           }
       }

}
