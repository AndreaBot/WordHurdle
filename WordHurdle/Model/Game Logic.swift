//
//  Game Logic.swift
//  WordHurdle
//
//  Created by Andrea Bottino on 02/11/2023.
//

import UIKit

protocol GameLogicDelegate {
    func saveStats()
    func loadStats()
    func enableKeyboard()
    func disableKeyboard()
    func resetBoxes()
    func setBordersAndNavButtons()
    func showCheckResults()
}

struct GameLogic {
    
    static let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appending(path: "Stats.plist")
    
    static var delegate: GameLogicDelegate?
    static var characterArray = [String]()
    static var checkResults = [Int]()
    static var labelArrayIndex = 0
    static var labelIndex = 0 {
        didSet {
            delegate?.setBordersAndNavButtons()
        }
    }
    static var randomWord = "" {
        didSet {
            var characterIndex = 0
            for _ in randomWord {
                let char = String(randomWord[randomWord.index(randomWord.startIndex, offsetBy: characterIndex)])
                characterArray.append(char)
                AllLetters.addCounter(char)
                characterIndex += 1
            }
            print(randomWord)
        }
    }
    
    static func performCheck(_ VC: UIViewController, _ allAttempts: [[UILabel]]) {
        var guessedLetters = [String]()
        checkResults = [0, 0, 0, 0, 0]
        
        for label in allAttempts[labelArrayIndex] {
            guessedLetters.append(label.text!)
        }
        
        if AllWords.words.contains(where: { gameWord in
            let guess = guessedLetters.joined()
            return gameWord == guess
        }) {
            checkGreen()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                checkRest()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                delegate?.showCheckResults()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                progressGame(VC, allAttempts)
            }
        } else {
            Alerts.timedAlert(VC, guessedLetters.joined())
        }
        
        func checkGreen() {
            var labelIndex = 0
            
            for letter in guessedLetters {
                if letter == characterArray[labelIndex] {
                    checkResults[labelIndex] = 3
                    AllLetters.letters[letter]! -= 1
                }
                labelIndex += 1
            }
        }
        
        func checkRest() {
            var labelIndex = 0
            for letter in guessedLetters {
                
                if characterArray.contains(where: { string in string == letter}) && AllLetters.letters[letter]! > 0 {
                    
                    if checkResults[labelIndex] != 3 {
                        checkResults[labelIndex] = 2
                        AllLetters.letters[letter]! -= 1
                    }
                } else if !characterArray.contains(where: { string in string == letter })
                            || characterArray.contains(where: { string in string == letter}) && (AllLetters.letters[letter]! == 0) {
                    
                    if checkResults[labelIndex] != 3 {
                        checkResults[labelIndex] = 1
                    }
                }
                labelIndex += 1
            }
        }
    }
    
    static private func progressGame(_ VC: UIViewController, _ allAttempts: [[UILabel]]) {
        var alertTitle = ""
        var alertMessage = ""
        
        if checkResults.allSatisfy({ Int in
            Int == 3
        }) {
            //CORRECT WORD GUESSED (GAME WON)
            alertTitle = "Congrats!"
            alertMessage = "You succeeded!"
            Alerts.endGameAlert(VC, alertTitle, alertMessage, {
                self.startNewGame(allAttempts)
            }, { delegate?.loadStats()})
            delegate?.disableKeyboard()
            
            PlayerStats.stats[0].value += 1
            PlayerStats.stats[1].value += 1
            PlayerStats.stats[2].value += 1
            if PlayerStats.stats[2].value > PlayerStats.stats[3].value {
                PlayerStats.stats[3].value = PlayerStats.stats[2].value
            }
            delegate?.saveStats()
            
        } else {
            //WRONG WORD GUESSED AND MORE ATTEMPTS REMAIN
            if labelArrayIndex + 1 <= allAttempts.count - 1 {
                
                var index = 0
                
                for result in checkResults {
                    if result == 3 || result == 2 {
                        AllLetters.letters[allAttempts[labelArrayIndex][index].text!]! += 1
                    }
                    index += 1
                }
                labelArrayIndex += 1
                labelIndex = 0
                
            } else {
                //WRONG WORD GUESSED AND NO MORE ATTEMPTS REMAIN (GAME LOST)
                alertTitle = "Darn it..."
                alertMessage = "The secret word was: \n\(randomWord.uppercased())"
                Alerts.endGameAlert(VC, alertTitle, alertMessage, {
                    self.startNewGame(allAttempts)
                }, { delegate?.loadStats()})
                delegate?.disableKeyboard()
                PlayerStats.stats[0].value += 1
                PlayerStats.stats[2].value = 0
                delegate?.saveStats()
            }
        }
    }
    
    static func startNewGame(_ allAttempts: [[UILabel]]) {
        AllLetters.resetCounters()
        characterArray = [String]()
        delegate?.resetBoxes()
        randomWord = AllWords.words.randomElement()!
        labelArrayIndex = 0
        labelIndex = 0
        delegate?.enableKeyboard()
        delegate?.loadStats()
    }
}
