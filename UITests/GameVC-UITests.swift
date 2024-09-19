//
//  UITests.swift
//  UITests
//
//  Created by Andrea Bottino on 18/09/2024.
//

import XCTest

final class UITests: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
    }
    
    
    //MARK: - Identifiers
    
    let firstRowIdentifiers = ["1stAttempt1", "1stAttempt2", "1stAttempt3", "1stAttempt4", "1stAttempt5"]
    let secondRowIdentifiers = ["2ndAttempt1", "2ndAttempt2", "2ndAttempt3", "2ndAttempt4", "2ndAttempt5"]
    let thirdRowIdentifiers = ["3rdAttempt1", "3rdAttempt2", "3rdAttempt3", "3rdAttempt4", "3rdAttempt5"]
    let fourthRowIdentifiers = ["4thAttempt1", "4thAttempt2", "4thAttempt3", "4thAttempt4", "4thAttempt5"]
    let fifthRowIdentifiers = ["5thAttempt1", "5thAttempt2", "5thAttempt3", "5thAttempt4", "5thAttempt5"]
    let sixthRowIdentifiers = ["6thAttempt1", "6thAttempt2", "6thAttempt3", "6thAttempt4", "6thAttempt5"]
    
    let supportButtonIdentifiers = ["newGameButton", "showStatsButton", "backButton", "clearButton", "forwardButton", "submitButton", "deleteButton"]
    
    
    //MARK: - Support functions
    
    func launchApp() -> XCUIApplication {
        let app = XCUIApplication()
        app.launch()
        return app
    }
    
    func launchAppWithTestWord(_ word: String) -> XCUIApplication {
        let app = XCUIApplication()
        app.launchEnvironment["TEST_WORD"] = word
        app.launch()
        return app
    }
    
    func typeWord(_ word: String, in app: XCUIApplication) {
        for letter in word {
            app.buttons[String(letter)].tap()
        }
    }
    
    
    //MARK: - Test UI elements existence
    
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
    
    
    //MARK: - Test boxes get filled and cleared
    
    func testTappingLetterPopulatesBox() {
        let app = launchApp()
        
        app.buttons["A"].tap()
        XCTAssertEqual(app.staticTexts[firstRowIdentifiers[0]].label, "A", "The type letter does not fill the first box")
    }
    
    func testAttemptGetsFullyFilled() {
        let app = launchApp()
        
        typeWord("FLAME", in: app)
        
        for id in firstRowIdentifiers {
            XCTAssertTrue(!app.staticTexts[id].label.isEmpty, "The box named \(id) has no text")
        }
    }
    
    func testClearButtonEmptiesRow() {
        let app = launchApp()
        typeWord("FLAME", in: app)
        app.buttons["clearButton"].tap()
        
        for id in firstRowIdentifiers {
            XCTAssertTrue(app.staticTexts[id].label.isEmpty, "The row has not been cleared")
        }
    }
    
    
    //MARK: - Test alerts presentation and interaction
    
    func testInvalidWordAlertAppearsAndDisappears() {
        let app = launchApp()
        typeWord("WGSRT", in: app)
        app.buttons["submitButton"].tap()
        
        XCTAssertTrue(app.otherElements["timedAlert"].waitForExistence(timeout: 1))
        XCTAssertFalse(app.otherElements["timedAlert"].waitForExistence(timeout: 5))
    }
    
    func testGameWonAlert() {
        let app = launchAppWithTestWord("FLAME")
        
        typeWord("FLAME", in: app)
        app.buttons["submitButton"].tap()
        XCTAssertTrue(app.alerts["endGameAlert"].waitForExistence(timeout: 5))
    }
    
    func testGameLostAlert() {
        let app = launchAppWithTestWord("FLAME")
        let allRows = [firstRowIdentifiers, secondRowIdentifiers, thirdRowIdentifiers, fourthRowIdentifiers, fifthRowIdentifiers, sixthRowIdentifiers]
        
        for _ in allRows.indices {
            typeWord("SCARF", in: app)
            app.buttons["submitButton"].tap()
            sleep(2)
        }
        
        XCTAssertTrue(app.alerts["endGameAlert"].waitForExistence(timeout: 5), "The end game alert was not presented")
    }
    
    func testStartNewGameFromAlert() {
        let app = launchAppWithTestWord("FLAME")
        let allRows = [firstRowIdentifiers, secondRowIdentifiers, thirdRowIdentifiers, fourthRowIdentifiers, fifthRowIdentifiers, sixthRowIdentifiers]
        typeWord("FLAME", in: app)
        app.buttons["submitButton"].tap()
        sleep(2)
        app.alerts["endGameAlert"].buttons["New Game"].tap()
        
        for row in allRows {
            for id in row {
                XCTAssertTrue(app.staticTexts[id].label.isEmpty)
            }
        }
    }
    
    
    //MARK: - Test performance
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

