//
//  PlantsAppUITests.swift
//  PlantsAppUITests
//
//  Created by Baris Dilekci on 24.11.2023.
//

import XCTest
@testable import PlantsApp

final class PlantsAppUITests: XCTestCase {
    let app = XCUIApplication()
    
    
    
    func testLaunch() throws {
        app.launch()
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    func testAddPlantButton() throws {
        app.launch()
        app.navigationBars["Bitkilerim"].buttons["Bitki Ekle"].tap()
    }
    
    func testAddPlantData() throws {
        
        app.launch()
        app.navigationBars["Bitkilerim"].buttons["Bitki Ekle"].tap()
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.textFields["Bitki İsmi"].press(forDuration: 1.5);
        
        let bitkiAKlamasTextField = collectionViewsQuery.textFields["Bitki Açıklaması"]
        bitkiAKlamasTextField.tap()
        bitkiAKlamasTextField.tap()
        collectionViewsQuery.buttons["Fotoğraf seç"].tap()
        app.scrollViews.otherElements.images["Photo, August 09, 2012, 12:55 AM"].tap()
    }
    
    func testPlantDetail() throws {
        app.launch()
        XCUIApplication().collectionViews/*@START_MENU_TOKEN@*/.buttons["Yaprağı, Yaprak "]/*[[".cells.buttons[\"Yaprağı, Yaprak \"]",".buttons[\"Yaprağı, Yaprak \"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }

}





