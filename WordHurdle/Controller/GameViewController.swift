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
    var index = 0
    
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
    
    func setTextFieldDelegate(_ txtFieldArray: [UITextField]) {
        for txtBox in txtFieldArray {
            txtBox.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        setTextFieldDelegate(firstAttempt)
        setTextFieldDelegate(secondAttempt)
        
    }
    
    
    @IBAction func checkIsPressed(_ sender: UIButton) {
        let allAttempts = [firstAttempt, secondAttempt]
        var guessedLetters = [String]()
        
        for textField in allAttempts[txtFieldArrayIndex]! {
            guessedLetters.append(textField.text!)
        }
        
        if AllWords.words.contains(where: { gameWord in
            let guess = guessedLetters.joined()
            return gameWord == guess
        }) {
            checkGuess(allAttempts[txtFieldArrayIndex]!)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                progressGame()
            }} else {
                timedAlert(guessedLetters.joined())
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
    
    func timedAlert(_ guess: String) {
        let alert = UIAlertController(title: "Try again", message: "\(guess.uppercased()) is not a valid word", preferredStyle: .actionSheet)
        present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.dismiss(animated: true)
        }
        
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

extension GameViewController: UITextFieldDelegate {

    func moveToNextTextField(currentTextField: UITextField) {
        let allAttempts = [firstAttempt, secondAttempt]
        if let currentIndex = allAttempts[txtFieldArrayIndex]!.firstIndex(of: currentTextField) {
            if currentIndex + 1 <= 4 {
                let nextTextField = allAttempts[txtFieldArrayIndex]![currentIndex + 1]
                nextTextField.becomeFirstResponder()
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        
        if newText.count > 1 {
            return false
        }
        if newText.count == 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                self.moveToNextTextField(currentTextField: textField)
            }
        }
        return true
    }
}






