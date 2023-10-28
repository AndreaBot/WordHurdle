//
//  GameViewController.swift
//  WordHurdle
//
//  Created by Andrea Bottino on 27/10/2023.
//

import UIKit

class GameViewController: UIViewController {
    
    
    @IBOutlet var firstAttempt: [UITextField]!
    @IBOutlet var secondAttempt: [UITextField]!
    
    var characterArray = [String]()
    var txtFieldArrayIndex = 0
    
    var randomWord = "" {
        didSet {
            var characterIndex = 0
            for _ in randomWord {
                let char = randomWord[randomWord.index(randomWord.startIndex, offsetBy: characterIndex)]
                characterArray.append(String(char))
                characterIndex += 1
            }
        }
    }
    
    func disableTxtFields(_ fieldsArray: [UITextField]) {
        for field in fieldsArray {
            field.isEnabled = false
        }
    }
    
    func enableTxtFields(_ fieldsArray: [UITextField]) {
        for field in fieldsArray {
            field.isEnabled = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
    }
    
    
    @IBAction func checkIsPressed(_ sender: UIButton) {
        let allAttempts = [firstAttempt, secondAttempt]
        var guessedLetters = [String]()
        
        for textField in allAttempts[txtFieldArrayIndex]! {
            guessedLetters.append(textField.text!)
        }
        
        checkGuess(allAttempts[txtFieldArrayIndex]!)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            progressGame()
        }
        
        func checkGuess(_ txtFieldArray: [UITextField]) {
            var txtFieldIndex = 0
            
            for letter in guessedLetters {
                if letter == characterArray[txtFieldIndex] {
                    txtFieldArray[txtFieldIndex].backgroundColor = .systemGreen
                } else if characterArray.contains(where: { string in
                    string == letter
                }) {
                    txtFieldArray[txtFieldIndex].backgroundColor = .systemYellow
                } else {
                    txtFieldArray[txtFieldIndex].backgroundColor = .systemGray
                }
                txtFieldIndex += 1
            }
        }
        
        func progressGame() {
            var alertTitle = ""
            var alertMessage = ""
            if allAttempts[txtFieldArrayIndex]!.allSatisfy({ UITextField in
                UITextField.backgroundColor == .systemGreen
            }) {
                alertTitle = "Congrats!"
                alertMessage = "You succeeded!"
                endGameAlert(alertTitle, alertMessage)
            } else {
                if txtFieldArrayIndex + 1 <= (allAttempts.count - 1) {
                    disableTxtFields(allAttempts[txtFieldArrayIndex]!)
                    txtFieldArrayIndex += 1
                    enableTxtFields(allAttempts[txtFieldArrayIndex]!)
                } else {
                    alertTitle = "Darn it..."
                    alertMessage = "The secret word was: \n\(randomWord.uppercased())"
                    endGameAlert(alertTitle, alertMessage)
                }
            }
        }
    }
    
    func endGameAlert(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "New Game", style: .default, handler: { UIAlertAction in
            self.startNewGame()
        }))
        present(alert, animated: true)
    }
    
    func startNewGame() {
        txtFieldArrayIndex = 0
        characterArray = [String]()
        randomWord = AllWords.words.randomElement()!
        print(randomWord)
        
        let allAttempts = [firstAttempt, secondAttempt]
        enableTxtFields(allAttempts[0]!)
        disableTxtFields(allAttempts[1]!)
        
        for attempt in allAttempts {
            for box in attempt! {
                box.text = ""
                box.backgroundColor = .white
            }
        }
    }
}





