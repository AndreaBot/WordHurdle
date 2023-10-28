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
                print(characterArray)
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
        randomWord = AllWords.words.randomElement()!
        print(randomWord)
        
        let allAttempts = [firstAttempt, secondAttempt]
        disableTxtFields(allAttempts[1]!)
        
    }
    
    
    @IBAction func checkIsPressed(_ sender: UIButton) {
        let allAttempts = [firstAttempt, secondAttempt]
        var guessedLetters = [String]()
        
        for textField in allAttempts[txtFieldArrayIndex]! {
            guessedLetters.append(textField.text!)
        }
        
        checkGuess(allAttempts[txtFieldArrayIndex]!)
        
        disableTxtFields(allAttempts[txtFieldArrayIndex]!)
        
        if txtFieldArrayIndex + 1 <= (allAttempts.count - 1) {
            txtFieldArrayIndex += 1
            enableTxtFields(allAttempts[txtFieldArrayIndex]!)
        }
        
        func checkGuess(_ txtFieldArray: [UITextField]) {
            var txtFieldIndex = 0
            
            for letter in guessedLetters {
                if letter == characterArray[txtFieldIndex] {
                    txtFieldArray[txtFieldIndex].backgroundColor = .systemGreen
                }  else if characterArray.contains(where: { string in
                    string == letter
                }) {
                    txtFieldArray[txtFieldIndex].backgroundColor = .systemYellow
                } else {
                    txtFieldArray[txtFieldIndex].backgroundColor = .systemGray
                }
                
                txtFieldIndex += 1
            }
        }
    }
}
