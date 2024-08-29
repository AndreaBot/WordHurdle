//
//  Game Logic.swift
//  WordHurdle
//
//  Created by Andrea Bottino on 02/11/2023.
//

import Foundation


class GameLogic {
    
    let allLetters: AllLetters

    var allAttempts = [[String]]() {
        didSet {
            if !allAttempts.isEmpty {
                delegate?.updateCurrentLabel()
            }
        }
    }
    
    var delegate: GameLogicDelegate?
    var keyboardManager: KeyboardManager?
    var alertsDelegate: AlertsDelegate?
    var statsManager: StatsManagerProtocol
    
    var correctCharacterArray = [String]()
    var checkResults = [CheckResults]()
    var labelArrayIndex = 0
    var labelIndex = 0 {
        didSet {
            delegate?.setBordersAndNavButtons()
        }
    }
    var randomWord = "" {
        didSet {
            for character in randomWord {
                correctCharacterArray.append(String(character))
                allLetters.addCounter(String(character))
            }
            print(randomWord)
        }
    }
    
    init(allLetters: AllLetters, statsManager: StatsManagerProtocol) {
        self.allLetters = allLetters
        self.statsManager = PlayerStats()
    }
    
    func performCheck(_ allAttempts: [[String]]) {
        guard allAttempts[labelArrayIndex].allSatisfy({ text in
            text != ""
        }) else {
            return
        }
        
        var guessedLetters = [String]()
        checkResults = [.neutral, .neutral, .neutral, .neutral, .neutral]
        
        for letter in allAttempts[labelArrayIndex] {
            guessedLetters.append(letter)
        }
        
        guard AllWords.words.contains(where: { word in
            let guess = guessedLetters.joined()
            return word == guess
        }) else {
            alertsDelegate?.showNonExistentWordAlert(guessedLetters.joined())
            return
        }
        
        checkGreen(guessedLetters: guessedLetters, correctCharacterArray: correctCharacterArray)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.checkRest(guessedLetters: guessedLetters, correctCharacterArray: self.correctCharacterArray)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.delegate?.showCheckResults()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.progressGame(allAttempts)
        }
    }
    
    func checkGreen(guessedLetters: [String], correctCharacterArray: [String]) {
        var index = 0
        for letter in guessedLetters {
            if letter == correctCharacterArray[index] {
                checkResults[index] = .correctLetterPlacement
                allLetters.letters[letter]! -= 1
            }
            index += 1
        }
    }
    
    func checkRest(guessedLetters: [String], correctCharacterArray: [String]) {
        var index = 0
        for letter in guessedLetters {
            if checkResults[index] != .correctLetterPlacement {
                if allLetters.letters[letter]! > 0 {
                    checkResults[index] = .wrongLetterPlacement
                    allLetters.letters[letter]! -= 1
                    
                } else {
                    checkResults[index] = .letterNotPresent
                }
            }
            index += 1
        }
    }
    
    private func progressGame(_ allAttempts: [[String]]) {
        var alertTitle = ""
        var alertMessage = ""
        
        if checkResults.allSatisfy({ result in
            result == .correctLetterPlacement
        }) {
            //CORRECT WORD GUESSED (GAME WON)
            alertTitle = "Congrats!"
            alertMessage = "You succeeded!"
            keyboardManager?.disableKeyboard()
            alertsDelegate?.showEndMessage(title: alertTitle, message: alertMessage)
            
            statsManager.stats[0].value += 1
            statsManager.stats[1].value += 1
            statsManager.stats[2].value += 1
            if statsManager.stats[2].value > statsManager.stats[3].value {
                statsManager.stats[3].value = statsManager.stats[2].value
            }
            statsManager.setGuessDistribution(index: labelArrayIndex)
            statsManager.saveStats()
            
        } else {
            //WRONG WORD GUESSED AND MORE ATTEMPTS REMAIN
            if labelArrayIndex + 1 <= allAttempts.count - 1 {
                
                var index = 0
                
                for result in checkResults {
                    if result == .correctLetterPlacement || result == .wrongLetterPlacement {
                        let currentLetter = allAttempts[labelArrayIndex][index]
                        allLetters.letters[currentLetter]! += 1
                    }
                    index += 1
                }
                labelArrayIndex += 1
                labelIndex = 0
                
            } else {
                //WRONG WORD GUESSED AND NO MORE ATTEMPTS REMAIN (GAME LOST)
                alertTitle = "Darn it..."
                alertMessage = "The secret word was: \n\(randomWord.uppercased())"
                keyboardManager?.disableKeyboard()
                alertsDelegate?.showEndMessage(title: alertTitle, message: alertMessage)
                statsManager.stats[0].value += 1
                statsManager.stats[2].value = 0
                statsManager.saveStats()
            }
        }
    }
    
    func startNewGame() {
        allLetters.resetCounters()
        correctCharacterArray = [String]()
        delegate?.resetBoxes()
        randomWord = AllWords.words.randomElement()!
        labelArrayIndex = 0
        labelIndex = 0
        keyboardManager?.enableKeyboard()
        statsManager.loadStats()
        resetAllAttempts()
    }
    
    func appendToAttempts(text: String) {
        allAttempts[labelArrayIndex][labelIndex] = text
    }
    
    func clear() {
        for i in 0..<allAttempts[labelArrayIndex].count {
            allAttempts[labelArrayIndex][i] = ""
        }
        labelIndex = 0
    }
    
    func deleteLetter() {
        allAttempts[labelArrayIndex][labelIndex] = ""
    }
    
    func resetAllAttempts() {
        allAttempts = []
        for _ in 0...5 {
            allAttempts.append(["", "", "", "", ""])
        }
    }
}




