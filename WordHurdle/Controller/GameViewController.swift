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
    @IBOutlet var thirdAttempt: [UITextField]!
    @IBOutlet var fourthAttempt: [UITextField]!
    @IBOutlet var fifthAttempt: [UITextField]!
    @IBOutlet var sixthAttempt: [UITextField]!
    
    @IBOutlet weak var checkButton: UIButton!
    
    var allAttempts = [[UITextField]]()
    var characterArray = [String]()
    var txtFieldArrayIndex = 0
    
    var randomWord = "" {
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
    
    func disableTxtFields(_ txtFieldsArray: [UITextField]) {
        for txtField in txtFieldsArray {
            txtField.isEnabled = false
        }
    }
    
    func enableTxtFields(_ txtFieldsArray: [UITextField]) {
        for txtField in txtFieldsArray {
            txtField.isEnabled = true
        }
    }
    
    func setTextFieldDelegate(_ txtField: UITextField) {
        txtField.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allAttempts = [firstAttempt, secondAttempt, thirdAttempt, fourthAttempt, fifthAttempt, sixthAttempt]
        startNewGame()
        let exitKeyboard = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(exitKeyboard)
    }
    
    
    @IBAction func newGameIsPressed(_ sender: UIButton) {
        startNewGame()
    }
    
    @IBAction func checkIsPressed(_ sender: UIButton) {
        if allAttempts[txtFieldArrayIndex].allSatisfy({ UITextField in
            UITextField.text != ""
        }) {
            performCheck()
        }
    }
    
    func performCheck() {
        var guessedLetters = [String]()
        
        for textField in allAttempts[txtFieldArrayIndex] {
            guessedLetters.append(textField.text!)
        }
        
        if AllWords.words.contains(where: { gameWord in
            let guess = guessedLetters.joined()
            return gameWord == guess
        }) {
            checkGreen(allAttempts[txtFieldArrayIndex])
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [self] in
                checkRest(allAttempts[txtFieldArrayIndex])
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                progressGame()
            }
        } else {
            timedAlert(guessedLetters.joined())
        }
        
        func checkGreen(_ txtFieldArray: [UITextField]) {
            var txtFieldIndex = 0
            
            for letter in guessedLetters {
                if letter == characterArray[txtFieldIndex] {
                    txtFieldArray[txtFieldIndex].backgroundColor = .systemGreen
                    AllLetters.letters[letter]! -= 1
                }
                txtFieldIndex += 1
            }
        }
        
        func checkRest(_ txtFieldArray: [UITextField]) {
            var txtFieldIndex = 0
            
            for letter in guessedLetters {
                
                if characterArray.contains(where: { string in
                    string == letter
                }) && (AllLetters.letters[letter]! > 0) {
                    if txtFieldArray[txtFieldIndex].backgroundColor != .systemGreen {
                        txtFieldArray[txtFieldIndex].backgroundColor = .systemYellow
                    }
                } else if !characterArray.contains(where: { string in
                    string == letter
                }) || characterArray.contains(where: { string in
                    string == letter
                }) && (AllLetters.letters[letter]! == 0) {

                    if txtFieldArray[txtFieldIndex].backgroundColor != .systemGreen {
                        txtFieldArray[txtFieldIndex].backgroundColor = .systemGray
                    }
                }
                
                txtFieldIndex += 1
            }
        }

        func progressGame() {
            var alertTitle = ""
            var alertMessage = ""
            
            if allAttempts[txtFieldArrayIndex].allSatisfy({ UITextField in
                UITextField.backgroundColor == .systemGreen
            }) {
                alertTitle = "Congrats!"
                alertMessage = "You succeeded!"
                endGameAlert(alertTitle, alertMessage)
                checkButton.isEnabled = false
                for attempt in allAttempts {
                    disableTxtFields(attempt)
                }
                
            } else {
                
                if txtFieldArrayIndex + 1 <= (allAttempts.count - 1) {
                    disableTxtFields(allAttempts[txtFieldArrayIndex])
                    for txtField in allAttempts[txtFieldArrayIndex] {
                        if txtField.backgroundColor == .systemGreen {
                            AllLetters.letters[txtField.text!]! += 1
                        }
                    }
                    txtFieldArrayIndex += 1
                    enableTxtFields(allAttempts[txtFieldArrayIndex])
                    allAttempts[txtFieldArrayIndex][0].becomeFirstResponder()
                    
                } else {
                    alertTitle = "Darn it..."
                    alertMessage = "The secret word was: \n\(randomWord.uppercased())"
                    endGameAlert(alertTitle, alertMessage)
                    checkButton.isEnabled = false
                    for attempt in allAttempts {
                        disableTxtFields(attempt)
                    }
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.dismiss(animated: true)
        }
        
    }
    
    func startNewGame() {
        AllLetters.resetCounters()
        
        for attempt in allAttempts {
            for txtField in attempt {
                setTextFieldDelegate(txtField)
                txtField.layer.borderColor = CGColor(red: 0, green: 0.3, blue: 1, alpha: 1)
                txtField.text = ""
                txtField.textColor = UIColor(white: 0.2, alpha: 1)
                txtField.backgroundColor = .white
                txtField.layer.borderWidth = 0
                txtField.returnKeyType = .done
                txtField.autocorrectionType = .no
                txtField.spellCheckingType = .no
            }
        }
        
        characterArray = [String]()
        randomWord = AllWords.words.randomElement()!
        print(randomWord)
        
        enableTxtFields(allAttempts[0])
        for txtFieldArray in allAttempts.dropFirst() {
            disableTxtFields(txtFieldArray)
        }
        
        txtFieldArrayIndex = 0
        allAttempts[txtFieldArrayIndex][0].becomeFirstResponder()
        checkButton.isEnabled = true
    }
}

extension GameViewController: UITextFieldDelegate {
    
    func moveToNextTextField(currentTextField: UITextField) {
        if let currentIndex = allAttempts[txtFieldArrayIndex].firstIndex(of: currentTextField) {
            if currentIndex + 1 <= 4 {
                let nextTextField = allAttempts[txtFieldArrayIndex][currentIndex + 1]
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 0
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = textField.frame.height/15
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if allAttempts[txtFieldArrayIndex].allSatisfy({ UITextField in
            UITextField.text != ""
        }) { 
            performCheck()
            return true
        } else {
            return false
        }
    }
}
    






