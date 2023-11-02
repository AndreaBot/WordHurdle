//
//  GameViewController.swift
//  WordHurdle
//
//  Created by Andrea Bottino on 27/10/2023.
//

import UIKit
import IQKeyboardManagerSwift

class GameViewController: UIViewController {
    
    
    @IBOutlet var firstAttempt: [UITextField]!
    @IBOutlet var secondAttempt: [UITextField]!
    @IBOutlet var thirdAttempt: [UITextField]!
    @IBOutlet var fourthAttempt: [UITextField]!
    @IBOutlet var fifthAttempt: [UITextField]!
    @IBOutlet var sixthAttempt: [UITextField]!
    
    @IBOutlet weak var checkButton: UIButton!
    
    var allAttempts = [[UITextField]]()

    @objc func clear() {
        let currentAttempt = allAttempts[GameLogic.txtFieldArrayIndex]
        currentAttempt[0].becomeFirstResponder()
        for attempt in currentAttempt {
            attempt.text = ""
        }
    }
    
    func setTextFieldDelegate(_ txtField: UITextField) {
        txtField.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allAttempts = [firstAttempt, secondAttempt, thirdAttempt, fourthAttempt, fifthAttempt, sixthAttempt]
        setup()
        GameLogic.startNewGame(allAttempts)
    }
    
    
    @IBAction func newGameIsPressed(_ sender: UIButton) {
        GameLogic.startNewGame(allAttempts)
    }
    
    @IBAction func checkIsPressed(_ sender: UIButton) {
        if allAttempts[GameLogic.txtFieldArrayIndex].allSatisfy({ UITextField in
            UITextField.text != ""
        }) {
            GameLogic.performCheck(self, allAttempts)
        }
    }
    
    func setup() {
        GameLogic.delegate = self
        let exitKeyboard = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(exitKeyboard)
        for attempt in allAttempts {
            for txtField in attempt {
                setTextFieldDelegate(txtField)
                txtField.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(clear))
                txtField.autocorrectionType = .no
                txtField.spellCheckingType = .no
                txtField.borderStyle = .roundedRect
                txtField.layer.cornerRadius = txtField.frame.height/10
                txtField.layer.masksToBounds = true
                txtField.returnKeyType = .done
                txtField.font = UIFont.systemFont(ofSize: 20)
                txtField.textColor = UIColor(white: 0.2, alpha: 1)
                txtField.layer.borderColor = CGColor(red: 0, green: 0.3, blue: 1, alpha: 1)
            }
        }
    }
}

//MARK: - GameLogicDelegate

extension GameViewController: GameLogicDelegate {
    
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
    
    func toggleCheckButton() {
        checkButton.isEnabled.toggle()
    }
}


//MARK: - UITextFieldDelegate

extension GameViewController: UITextFieldDelegate {
    
    func moveToNextTextField(currentTextField: UITextField) {
        if let currentIndex = allAttempts[GameLogic.txtFieldArrayIndex].firstIndex(of: currentTextField) {
            if currentIndex + 1 <= 4 {
                let nextTextField = allAttempts[GameLogic.txtFieldArrayIndex][currentIndex + 1]
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
       textField.layer.borderWidth = textField.frame.height/18
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if allAttempts[GameLogic.txtFieldArrayIndex].allSatisfy({ UITextField in
            UITextField.text != ""
        }) { 
            GameLogic.performCheck(self, allAttempts)
            return true
        } else {
            return false
        }
    }
}
    






