//
//  GameViewController.swift
//  WordHurdle
//
//  Created by Andrea Bottino on 27/10/2023.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet var firstAttempt: [UILabel]!
    @IBOutlet var secondAttempt: [UILabel]!
    @IBOutlet var thirdAttempt: [UILabel]!
    @IBOutlet var fourthAttempt: [UILabel]!
    @IBOutlet var fifthAttempt: [UILabel]!
    @IBOutlet var sixthAttempt: [UILabel]!
    
    @IBOutlet var keyboard: [UIButton]!
    
    @IBOutlet weak var newGameButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
    var allAttemptsLabels = [[UILabel]]()
    
    var gameLogic = GameLogic(allLetters: AllLetters())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allAttemptsLabels = [firstAttempt, secondAttempt, thirdAttempt, fourthAttempt, fifthAttempt, sixthAttempt]
        resetAllAttempts()
        setup()
        gameLogic.startNewGame()
    }
    
    
    @IBAction func newGameIsPressed(_ sender: UIButton) {
        gameLogic.startNewGame()
        resetAllAttempts()
    }
    
    @IBAction func navButtonIsPressed(_ sender: UIButton) {
        gameLogic.labelIndex = sender.tag == 1 ? (gameLogic.labelIndex - 1) : (gameLogic.labelIndex + 1)
        
    }
    
    @IBAction func clearButtonIsPressed(_ sender: UIButton) {
        gameLogic.clear()
    }
    
    @IBAction func letterIsPressed(_ sender: UIButton) {
        allAttemptsLabels[gameLogic.labelArrayIndex][gameLogic.labelIndex].text! = sender.currentTitle!
        gameLogic.appendToAttempts(text: sender.currentTitle!)
        
        if gameLogic.labelIndex < 4 {
            gameLogic.labelIndex += 1
        }
    }
    
    @IBAction func deleteIsPressed(_ sender: UIButton) {
        allAttemptsLabels[gameLogic.labelArrayIndex][gameLogic.labelIndex].text! = ""
        gameLogic.deleteLetter()
    }
    
    
    @IBAction func checkIsPressed(_ sender: UIButton) {
        gameLogic.performCheck(gameLogic.allAttempts)
    }
    
    func setup() {
        gameLogic.delegate = self
        newGameButton.layer.cornerRadius = newGameButton.frame.height/8
        for attempt in allAttemptsLabels {
            setupRow(row: attempt)
        }
    }
    
    func setupRow(row: [UILabel]) {
        for label in row {
            label.font = UIFont.systemFont(ofSize: label.frame.height * 0.25)
            label.textColor = UIColor(white: 0.2, alpha: 1)
            label.backgroundColor = .white
            label.textAlignment = .center
            label.layer.cornerRadius = label.frame.height/8
            label.layer.masksToBounds = true
            label.layer.borderColor = CGColor(red: 0, green: 0.3, blue: 1, alpha: 1)
        }
    }
    
    func resetLastBorder() {
        allAttemptsLabels[gameLogic.labelArrayIndex][gameLogic.labelIndex].layer.borderWidth = 0
    }
    
    func resetAllAttempts() {
        gameLogic.allAttempts = []
        
        for attempt in allAttemptsLabels {
            let attemptLetters = attempt.map { $0.text ?? "" }
            gameLogic.allAttempts.append(attemptLetters)
        }
    }
}


//MARK: - GameLogicDelegate

extension GameViewController: GameLogicDelegate {
    
    func clearRow() {
        for label in allAttemptsLabels[gameLogic.labelArrayIndex] {
            label.text = ""
        }
    }
    
    func showNonExistentWordAlert(_ word: String) {
        present(Alerts.timedAlert(word), animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.dismiss(animated: true)
        }
    }
    
    func showEndMessage(title: String, message: String) {
        present(Alerts.endGameAlert(title, message, {
            self.gameLogic.startNewGame()
            self.resetAllAttempts()
        }), animated: true)
    }
    
    
    func enableKeyboard() {
        for key in keyboard {
            key.isEnabled = true
        }
        backButton.isEnabled = gameLogic.labelIndex == 0 ? false : true
        forwardButton.isEnabled = true
        clearButton.isEnabled = true
    }
    
    func disableKeyboard() {
        for key in keyboard {
            key.isEnabled = false
        }
        backButton.isEnabled = false
        forwardButton.isEnabled = false
        clearButton.isEnabled = false
    }
    
    func resetBoxes() {
        for row in allAttemptsLabels {
            for view in row {
                view.text = ""
                if view.backgroundColor != .white {
                    UIView.transition(with: view, duration: 0.7, options: .transitionFlipFromRight) {
                        view.backgroundColor = .white
                    }
                }
                view.layer.borderWidth = 0
            }
        }
        for key in keyboard {
            UIView.transition(with: view, duration: 0.7, options: .transitionCrossDissolve) {
                key.backgroundColor = .white
            }
        }
    }
    
    func setBordersAndNavButtons() {
        let activeRow = allAttemptsLabels[gameLogic.labelArrayIndex]
        for label in activeRow {
            label.layer.borderWidth = 0
        }
        activeRow[gameLogic.labelIndex].layer.borderWidth = activeRow[gameLogic.labelIndex].layer.frame.height/20
        backButton.isEnabled = gameLogic.labelIndex == 0 ? false : true
        forwardButton.isEnabled = gameLogic.labelIndex == 4 ? false : true
    }
    
    func showCheckResults() {
        var index = 0
        var delay = 0.0
        
        for label in allAttemptsLabels[gameLogic.labelArrayIndex] {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                UIView.transition(with: label, duration: 0.7, options: .transitionFlipFromLeft) {
                    switch self.gameLogic.checkResults[index] {
                        
                    case .correctLetterPlacement:
                        label.backgroundColor = .systemGreen
                        UIView.transition(with: self.keyboard[index], duration: 0.7, options: .transitionCrossDissolve) {
                            self.colorKeys(label.text!, color: .systemGreen)
                        }
                    case .wrongLetterPlacement:
                        label.backgroundColor = .systemYellow
                    case .letterNotPresent:
                        label.backgroundColor = .systemGray
                        UIView.transition(with: self.keyboard[index], duration: 0.7, options: .transitionCrossDissolve) {
                            self.colorKeys(label.text!, color: .clear)
                        }
                    case .neutral:
                        label.backgroundColor = .clear
                    }
                }
                index += 1
            }
            delay += 0.18
        }
        resetLastBorder()
    }
    
    func colorKeys(_ letter: String, color: UIColor) {
        for key in keyboard.filter({ button in
            button.currentTitle == letter
        }) {
            key.backgroundColor = color
        }
    }
}






