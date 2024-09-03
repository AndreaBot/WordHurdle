//
//  AllLettersTests.swift
//  GameLogicTests
//
//  Created by Andrea Bottino on 02/09/2024.
//

import XCTest
@testable import WordHurdle

final class AllLettersTests: XCTestCase {
    
    var allLetters: AllLetters!
    
    override func setUpWithError() throws {
        allLetters = AllLetters()
    }
    
    override func tearDownWithError() throws {
        allLetters = nil
    }
    
    func test_addCounter_increasesValueByOne() {
        // GIVEN
        let letter = "A"
        let initialValue = allLetters.letters[letter]
        
        // WHEN
        allLetters.addCounter(letter)
        
        // THEN
        XCTAssertEqual(allLetters.letters[letter], initialValue! + 1)
    }
    
    func test_resetCounters_setsAllValuesToZero() {
        // GIVEN
        allLetters.letters["B"] = 5
        allLetters.letters["R"] = 3
        allLetters.letters["S"] = 10
        allLetters.letters["X"] = 24
        
        // WHEN
        allLetters.resetCounters()
        
        // THEN
        XCTAssertEqual( allLetters.letters["B"] , 0)
        XCTAssertEqual( allLetters.letters["R"] , 0)
        XCTAssertEqual( allLetters.letters["S"] , 0)
        XCTAssertEqual( allLetters.letters["X"] , 0)
    }
    
    func test_setupAllCounters_setValueForAllLetters() {
        // GIVEN
        let correctWord = "TYY"
        
        let firstCharacter = correctWord[correctWord.startIndex]
        let secondCharacter = correctWord[correctWord.index(correctWord.startIndex, offsetBy: 1)]
        let thirdCharacter = correctWord[correctWord.index(correctWord.startIndex, offsetBy: 2)]
        
        var instancesOfLetter1: Int {
            var instances = 0
            for character in correctWord {
                if character == correctWord.first {
                    instances += 1
                }
            }
            return instances
        }
        
        var instancesOfLetter2: Int {
            var instances = 0
            for character in correctWord {
                if character == secondCharacter {
                    instances += 1
                }
            }
            return instances
        }
        
        var instancesOfLetter3: Int {
            var instances = 0
            for character in correctWord {
                if character == secondCharacter {
                    instances += 1
                }
            }
            return instances
        }
        
        
        // WHEN
        allLetters.setupAllCounters(word: correctWord)
        
        // THEN
        XCTAssertEqual(allLetters.letters[String(firstCharacter)], instancesOfLetter1)
        XCTAssertEqual(allLetters.letters[String(secondCharacter)], instancesOfLetter2)
        XCTAssertEqual(allLetters.letters[String(thirdCharacter)], instancesOfLetter3)
        
    }
    
}
