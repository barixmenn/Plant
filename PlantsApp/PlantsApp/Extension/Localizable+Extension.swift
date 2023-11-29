//
//  Localizable+Extension.swift
//  PlantsApp
//
//  Created by Baris Dilekci on 29.11.2023.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
