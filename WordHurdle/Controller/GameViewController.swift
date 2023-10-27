//
//  GameViewController.swift
//  WordHurdle
//
//  Created by Andrea Bottino on 27/10/2023.
//

import UIKit

class GameViewController: UIViewController {
    
    
    @IBOutlet var firstAttempt: [UITextField]!
    
    
    var characterArray = [String]()
    
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
    
    func generateRandomWord() -> String {
        return AllWords.words.randomElement()!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        randomWord = generateRandomWord()
        print(randomWord)
    }
    
    
    @IBAction func checkIsPressed(_ sender: UIButton) {
        
        var guessedLetters = [String]()
        
        for textField in firstAttempt {
            guessedLetters.append(textField.text!)
            }
        
        checkGuess()
        
        for textField in firstAttempt {
            textField.isEnabled = false
        }
        
        func checkGuess() {
            var txtFieldIndex = 0
            for letter in guessedLetters {
                if letter == characterArray[txtFieldIndex] {
                    firstAttempt[txtFieldIndex].backgroundColor = .systemGreen
                }  else if characterArray.contains(where: { string in
                    string == letter
                }) {
                    firstAttempt[txtFieldIndex].backgroundColor = .systemYellow
                } else {
                    firstAttempt[txtFieldIndex].backgroundColor = .systemGray
                }
                txtFieldIndex += 1
            }
        }
    }
}
