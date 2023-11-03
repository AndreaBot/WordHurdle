//
//  Game Logic.swift
//  WordHurdle
//
//  Created by Andrea Bottino on 02/11/2023.
//

import UIKit

protocol GameLogicDelegate {
    func disableTxtFields(_ txtFieldsArray: [UITextField])
    func enableTxtFields(_ txtFieldsArray: [UITextField])
    func showCheckResults()
}

struct GameLogic {
    
    static var delegate: GameLogicDelegate?
    static var characterArray = [String]()
    static var txtFieldArrayIndex = 0
    static var checkResults = [Int]()
    static var randomWord = "" {
        didSet {
            var characterIndex = 0
            for _ in randomWord {
                let char = String(randomWord[randomWord.index(randomWord.startIndex, offsetBy: characterIndex)])
                characterArray.append(char)
                AllLetters.addCounter(char)
                characterIndex += 1
            }
        }
    }
    
    static func performCheck(_ VC: UIViewController, _ allAttempts: [[UITextField]]) {
        var guessedLetters = [String]()
        checkResults = [0, 0, 0, 0, 0]
        
        for textField in allAttempts[txtFieldArrayIndex] {
            guessedLetters.append(textField.text!)
        }
        
        if AllWords.words.contains(where: { gameWord in
            let guess = guessedLetters.joined()
            return gameWord == guess
        }) {
            checkGreen(allAttempts[txtFieldArrayIndex])
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                checkRest(allAttempts[txtFieldArrayIndex])
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
        
         func checkGreen(_ txtFieldArray: [UITextField]) {
            var txtFieldIndex = 0
            
            for letter in guessedLetters {
                if letter == characterArray[txtFieldIndex] {
                    checkResults[txtFieldIndex] = 3
                    AllLetters.letters[letter]! -= 1
                }
                txtFieldIndex += 1
            }
        }
        
         func checkRest(_ txtFieldArray: [UITextField]) {
            var txtFieldIndex = 0
            for letter in guessedLetters {
                
                if characterArray.contains(where: { string in string == letter}) && AllLetters.letters[letter]! > 0 {

                    if checkResults[txtFieldIndex] != 3 {
                        checkResults[txtFieldIndex] = 2
                        AllLetters.letters[letter]! -= 1
                    }
                } else if !characterArray.contains(where: { string in string == letter }) 
                            || characterArray.contains(where: { string in string == letter}) && (AllLetters.letters[letter]! == 0) {

                    if checkResults[txtFieldIndex] != 3 {
                        checkResults[txtFieldIndex] = 1
                    }
                }
                txtFieldIndex += 1
            }
        }
    }
    
    static private func progressGame(_ VC: UIViewController, _ allAttempts: [[UITextField]]) {
        var alertTitle = ""
        var alertMessage = ""
        
        if allAttempts[txtFieldArrayIndex].allSatisfy({ UITextField in
            UITextField.backgroundColor == .systemGreen
        }) {
            //CORRECT WORD GUESSED (GAME WON)
            alertTitle = "Congrats!"
            alertMessage = "You succeeded!"
            Alerts.endGameAlert(VC, alertTitle, alertMessage, {
                self.startNewGame(allAttempts)
            })
            for attempt in allAttempts {
                delegate?.disableTxtFields(attempt)
            }
            
        } else {
            //WRONG WORD GUESSED AND MORE ATTEMPTS REMAIN
            if txtFieldArrayIndex + 1 <= allAttempts.count - 1 {
                delegate?.disableTxtFields(allAttempts[txtFieldArrayIndex])
                for txtField in allAttempts[txtFieldArrayIndex] {
                    if txtField.backgroundColor == .systemGreen || txtField.backgroundColor == .systemYellow {
                        AllLetters.letters[txtField.text!]! += 1
                    }
                }
                txtFieldArrayIndex += 1
                delegate?.enableTxtFields(allAttempts[txtFieldArrayIndex])
                allAttempts[txtFieldArrayIndex][0].becomeFirstResponder()
                
            } else {
                //WRONG WORD GUESSED AND NO MORE ATTEMPTS REMAIN (GAME LOST)
                alertTitle = "Darn it..."
                alertMessage = "The secret word was: \n\(randomWord.uppercased())"
                Alerts.endGameAlert(VC, alertTitle, alertMessage, {
                    self.startNewGame(allAttempts)
                })
                for attempt in allAttempts {
                    delegate?.disableTxtFields(attempt)
                }
            }
        }
    }
    
    static func startNewGame(_ allAttempts: [[UITextField]]) {
        AllLetters.resetCounters()
        for attempt in allAttempts {
            for txtField in attempt {
                if txtField.backgroundColor != .white {
                    UIView.transition(with: txtField, duration: 0.65, options: .transitionFlipFromRight) {
                        txtField.text = ""
                        txtField.backgroundColor = .white
                        txtField.layer.borderWidth = 0
                    }
                }
            }
        }
        characterArray = [String]()
        randomWord = AllWords.words.randomElement()!
        print(randomWord)
        
        delegate?.enableTxtFields(allAttempts[0])
        for txtFieldArray in allAttempts.dropFirst() {
            delegate?.disableTxtFields(txtFieldArray)
        }
        
        GameLogic.txtFieldArrayIndex = 0
        allAttempts[txtFieldArrayIndex][0].becomeFirstResponder()
    }
}
