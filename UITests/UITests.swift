//
//  UITests.swift
//  UITests
//
//  Created by Andrea Bottino on 18/09/2024.
//

import XCTest

final class UITests: XCTestCase {
    
    let firstRowIdentifiers = ["1stAttempt1", "1stAttempt2", "1stAttempt3", "1stAttempt4", "1stAttempt5"]
    let secondRowIdentifiers = ["2ndAttempt1", "2ndAttempt2", "2ndAttempt3", "2ndAttempt4", "2ndAttempt5"]
    let thirdRowIdentifiers = ["3rdAttempt1", "3rdAttempt2", "3rdAttempt3", "3rdAttempt4", "3rdAttempt5"]
    let fourthRowIdentifiers = ["4thAttempt1", "4thAttempt2", "4thAttempt3", "4thAttempt4", "4thAttempt5"]
    let fifthRowIdentifiers = ["5thAttempt1", "5thAttempt2", "5thAttempt3", "5thAttempt4", "5thAttempt5"]
    let sixthRowIdentifiers = ["6thAttempt1", "6thAttempt2", "6thAttempt3", "6thAttempt4", "6thAttempt5"]
    
    let supportButtonIdentifiers = ["newGameButton", "showStatsButton", "backButton", "clearButton", "forwardButton", "submitButton", "deleteButton"]

    override func setUpWithError() throws {
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
    }

    func testGameHasSixAttemptsFiveBoxesEach() {
        let allRows = [firstRowIdentifiers, secondRowIdentifiers, thirdRowIdentifiers, fourthRowIdentifiers, fifthRowIdentifiers, sixthRowIdentifiers]
        
        let app = launchApp()
        
        for row in allRows {
            for id in row {
                XCTAssertTrue(app.staticTexts[id].exists, "The box named \(id) does not exist")
            }
        }
    }
    
    func testAppLaunchesWithEmptyBoxes() {
        let allRows = [firstRowIdentifiers, secondRowIdentifiers, thirdRowIdentifiers, fourthRowIdentifiers, fifthRowIdentifiers, sixthRowIdentifiers]
        
        let app = launchApp()
        
        for row in allRows {
            for id in row {
                XCTAssertTrue(app.staticTexts[id].label.isEmpty, "The box named \(id) is not clear")
            }
        }
    }
    
    func testKeybardHasAllLetters() {
        let app = launchApp()
        
        for letter in "ABCDEFGHIJKLMNOPQRSTUVWXYZ" {
            XCTAssertTrue(app.buttons[String(letter)].exists, "The keyboard is missing letter \(letter)")
        }
    }
    
    func testRestOfButtonsExist() {
        let app = launchApp()
        
        for id in supportButtonIdentifiers {
            XCTAssertTrue(app.buttons[id].exists, "The button \(id) does not exist")
        }
        
    }
    
    func testTappingLetterPopulatesBox() {
        let app = launchApp()
        
        app.buttons["A"].tap()
        XCTAssertEqual(app.staticTexts[firstRowIdentifiers[0]].label, "A", "The type letter does not fill the first box")
    }
    
    func testAttemptGetsFullyFilled() {
       let app = launchApp()
        
        typeTestWord(app: app)
        
        for id in firstRowIdentifiers {
            XCTAssertTrue(!app.staticTexts[id].label.isEmpty, "The box named \(id) has no text")
        }
    }
    
    func testClearButtonEmptiesRow() {
        let app = launchApp()
        typeTestWord(app: app)
        app.buttons["clearButton"].tap()
        
        for id in firstRowIdentifiers {
            XCTAssertTrue(app.staticTexts[id].label.isEmpty, "The row has not been cleared")
        }
    }
    
    func testInvalidWordAlertAppearsAndDisappears() {
        let app = launchApp()
        typeInvalidWord(app: app)
        app.buttons["submitButton"].tap()
        
        XCTAssertTrue(app.otherElements["timedAlert"].waitForExistence(timeout: 1))
        sleep(3)
        XCTAssertFalse(app.otherElements["timedAlert"].exists)
    }
    
    

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func launchApp() -> XCUIApplication {
        let app = XCUIApplication()
        app.launch()
        return app
    }
    
    func typeTestWord(app: XCUIApplication) {
        app.buttons["F"].tap()
        app.buttons["L"].tap()
        app.buttons["A"].tap()
        app.buttons["M"].tap()
        app.buttons["E"].tap()
    }
    
    func typeInvalidWord(app: XCUIApplication) {
        app.buttons["X"].tap()
        app.buttons["T"].tap()
        app.buttons["D"].tap()
        app.buttons["P"].tap()
        app.buttons["Z"].tap()
    }
}

