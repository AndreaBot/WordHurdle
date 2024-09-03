//
//  GameLogicTests.swift
//  GameLogicTests
//
//  Created by Andrea Bottino on 30/08/2024.
//

import XCTest
@testable import WordHurdle

class AlertDelegateMock: AlertsDelegate {
    var showingEndMessage = false
    var invalidWordRecognised = false
    
    func showEndMessage(title: String, message: String) {
        showingEndMessage = true
    }
    
    func showNonExistentWordAlert(_ word: String) {
       invalidWordRecognised = true
    }
}

final class GameLogicTests: XCTestCase {
    
    var gameLogic: GameLogic!
    
    override func setUpWithError() throws {
        gameLogic = GameLogic(allLetters: AllLetters(), statsManager: PlayerStats())
    }
    
    override func tearDownWithError() throws {
        gameLogic = nil
    }
    
    func test_GameLogic_initialisesWithCorrectStartValues() {
        XCTAssertTrue(gameLogic.labelArrayIndex == 0, "The initial value of labelArrayIndex is not zero")
        XCTAssertTrue(gameLogic.labelIndex == 0, "The initial value of labelIndex is not zero")
        XCTAssertTrue(gameLogic.allAttempts.isEmpty, "The allAttempts array is not empty at init")
        XCTAssertTrue(gameLogic.correctCharacterArray.isEmpty, "correctCharacterArray is not empty at init")
        XCTAssertTrue(gameLogic.checkResults.isEmpty, "The checkResults array is not empty at init")
    }
    
    func test_checkGreen_assignCorrectCheckResults() {
        // GIVEN
        gameLogic.checkResults = [.neutral, .neutral, .neutral, .neutral, .neutral]
        let guessedLetters = ["F", "L", "A", "M", "E"]
        let correctCharacterArray = ["F", "L", "A", "M", "E"]
        let expectedCheckResults: [CheckResults] = [.correctLetterPlacement, .correctLetterPlacement, .correctLetterPlacement, .correctLetterPlacement, .correctLetterPlacement]
        
        // WHEN
        gameLogic.checkGreen(guessedLetters: guessedLetters, correctCharacterArray: correctCharacterArray)
        
        // THEN
        for (index, result) in gameLogic.checkResults.enumerated() {
            XCTAssertEqual(result, expectedCheckResults[index], "Mismatch at index \(index)")
        }
    }
    
    func test_checkRest_assignCorrectCheckResults() {
        // GIVEN
        gameLogic.checkResults = [.neutral, .neutral, .neutral, .neutral, .neutral]
        let guessedLetters = ["X", "L", "A", "E", "P"]
        let correctCharacterArray = ["F", "L", "A", "M", "E"]
        gameLogic.allLetters.setupAllCounters(word: correctCharacterArray.joined())
        let expectedCheckResults: [CheckResults] = [.letterNotPresent, .wrongLetterPlacement, .wrongLetterPlacement, .wrongLetterPlacement, .letterNotPresent]
        
        // WHEN
        gameLogic.checkRest(guessedLetters: guessedLetters, correctCharacterArray: correctCharacterArray)
        
        // THEN
        for index in gameLogic.checkResults.indices {
           XCTAssertTrue(gameLogic.checkResults[index] == expectedCheckResults[index], "Failed at index \(index)")
        }
    }
    
    func test_PerformCheck_recognisesInvalidWord() {
        // GIVEN
        let alertsDelegate = AlertDelegateMock()
        gameLogic.alertsDelegate = alertsDelegate
        gameLogic.allAttempts.append(["X", "L", "A", "E", "P"])
        
        // WHEN
        gameLogic.performCheck(gameLogic.allAttempts)
        
        // THEN
        XCTAssertTrue(alertsDelegate.invalidWordRecognised, "ShwoingNonExistentWordAlert was not triggered")
    }
    
    func test_performCheck_recognisesValidWord() {
        // GIVEN
        let alertsDelegate = AlertDelegateMock()
        gameLogic.alertsDelegate = alertsDelegate
        gameLogic.allAttempts = [["F", "L", "A", "M", "E"]]
        
        // WHEN
        gameLogic.randomWord = "FLAME"
        gameLogic.performCheck(gameLogic.allAttempts)
        
        // THEN
        XCTAssertFalse(alertsDelegate.invalidWordRecognised, "ShowingNonExistentWordAlert was triggered")
    }
    
    func test_progressGame_endsGameWhenWordIsGuessed() {
        // GIVEN
        let alertsDelegate = AlertDelegateMock()
        gameLogic.alertsDelegate = alertsDelegate
        gameLogic.checkResults = [.correctLetterPlacement, .correctLetterPlacement, .correctLetterPlacement, .correctLetterPlacement, .correctLetterPlacement]
        
        // WHEN
        gameLogic.progressGame([])
        
        // THEN
        XCTAssertTrue(alertsDelegate.showingEndMessage, "showEndMessage was not triggered ")
    }
    
    func test_progressGame_EndsGameWhenNoAttemptsRemain() {
        // GIVEN
        let alertsDelegate = AlertDelegateMock()
        gameLogic.alertsDelegate = alertsDelegate
        gameLogic.checkResults = [.letterNotPresent, .correctLetterPlacement, .correctLetterPlacement, .correctLetterPlacement, .correctLetterPlacement]
        gameLogic.labelArrayIndex = 5
        
        // WHEN
        gameLogic.progressGame([])
        
        // THEN
        XCTAssertTrue(alertsDelegate.showingEndMessage, "showEndMessage was not triggered ")
    }
    
    func test_progressGame_continuesGameIfMoreAttemptsRemain() {
        // GIVEN
        let alertsDelegate = AlertDelegateMock()
        gameLogic.alertsDelegate = alertsDelegate
        gameLogic.labelArrayIndex = 0
        gameLogic.allAttempts = [["A", "L", "E", "R", "T"]]
        gameLogic.checkResults = [.letterNotPresent, .correctLetterPlacement, .correctLetterPlacement, .correctLetterPlacement, .correctLetterPlacement]
        
        // WHEN
        gameLogic.progressGame(gameLogic.allAttempts)
        
        // THEN
        XCTAssertFalse(alertsDelegate.showingEndMessage, "showEndMessage was triggered ")
    }
    
    func test_startNewGame_resetsEverything() {
        check_allLetters_resetCounters()
        XCTAssertEqual(gameLogic.labelArrayIndex, 0)
        XCTAssertEqual(gameLogic.labelIndex, 0)
        check_resetAllAttempts_resetsArray()
    }
    
    func check_allLetters_resetCounters() {
        let correctWord = "FLAME"
        gameLogic.allLetters.setupAllCounters(word: correctWord)
        gameLogic.allLetters.resetCounters()
        for letter in gameLogic.allLetters.letters {
            XCTAssertEqual(letter.value, 0, "The value for \(letter.key) was not reset to zero")
        }
    }
    
    func check_resetAllAttempts_resetsArray() {
        let allAttempts = [["A", "L", "E", "R", "T"],
                           ["A", "L", "E", "R", "T"],
                           ["A", "L", "E", "R", "T"]]
        gameLogic.allAttempts = allAttempts
        gameLogic.resetAllAttempts()
        XCTAssertEqual(gameLogic.allAttempts, [["", "", "", "", ""],
                                               ["", "", "", "", ""],
                                               ["", "", "", "", ""],
                                               ["", "", "", "", ""],
                                               ["", "", "", "", ""],
                                               ["", "", "", "", ""]])
    }
}
