//
//  PlantsAppUITestsLaunchTests.swift
//  PlantsAppUITests
//
//  Created by Baris Dilekci on 24.11.2023.
//

import XCTest

final class PlantsAppUITestsLaunchTests: XCTestCase {
    
    let app = XCUIApplication()
   // let addPlantButton = app.navigationBars["Bitkilerim"].buttons["Add"].tap()
    let addPlantButton = XCUIApplication().navigationBars["Bitkilerim"]/*@START_MENU_TOKEN@*/.buttons["Add"]/*[[".otherElements[\"Add\"].buttons[\"Add\"]",".buttons[\"Add\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
   

    func testLaunch() throws {
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}

