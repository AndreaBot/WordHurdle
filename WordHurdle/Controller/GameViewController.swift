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
    
    var allAttempts = [[UILabel]]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        allAttempts = [firstAttempt, secondAttempt, thirdAttempt, fourthAttempt, fifthAttempt, sixthAttempt]
        setup()
        GameLogic.startNewGame(allAttempts)
    }
    
    
    @IBAction func newGameIsPressed(_ sender: UIButton) {
        GameLogic.startNewGame(allAttempts)
    }
    
    @IBAction func navButtonIsPressed(_ sender: UIButton) {
        GameLogic.labelIndex = sender.tag == 1 ? (GameLogic.labelIndex - 1) : (GameLogic.labelIndex + 1)

    }
    
    @IBAction func clearButtonIsPressed(_ sender: UIButton) {
        for attempt in allAttempts[GameLogic.labelArrayIndex] {
            attempt.text = ""
        }
        GameLogic.labelIndex = 0
    }
    
    @IBAction func letterIsPressed(_ sender: UIButton) {
        
        sender.alpha = 0.7
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            sender.alpha = 1
        }
        
        let typedLetter = sender.currentTitle
        
        allAttempts[GameLogic.labelArrayIndex][GameLogic.labelIndex].text = typedLetter
        if GameLogic.labelIndex < 4 {
            GameLogic.labelIndex += 1
        }
    }
    
    
    @IBAction func checkIsPressed(_ sender: UIButton) {
        if allAttempts[GameLogic.labelArrayIndex].allSatisfy({ UILabel in
            UILabel.text != ""
        }) {
            GameLogic.performCheck(self, allAttempts)
        }
    }
    
    func setup() {
        GameLogic.delegate = self
        newGameButton.layer.cornerRadius = newGameButton.frame.height/8
        for attempt in allAttempts {
            for label in attempt {
                label.font = UIFont.systemFont(ofSize: label.frame.height * 0.25)
                label.textColor = UIColor(white: 0.2, alpha: 1)
                label.backgroundColor = .white
                label.textAlignment = .center
                label.layer.cornerRadius = label.frame.height/8
                label.layer.masksToBounds = true
                label.layer.borderColor = CGColor(red: 0, green: 0.3, blue: 1, alpha: 1)
            }
        }
    }
    
    func resetLastBorder() {
        allAttempts[GameLogic.labelArrayIndex][GameLogic.labelIndex].layer.borderWidth = 0
    }
}


//MARK: - GameLogicDelegate

extension GameViewController: GameLogicDelegate {
    
    func enableKeyboard() {
        for key in keyboard {
            key.isEnabled = true
        }
        backButton.isEnabled = true
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
        for row in allAttempts {
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
        let activeRow = allAttempts[GameLogic.labelArrayIndex]
        for label in activeRow {
            label.layer.borderWidth = 0
        }
        activeRow[GameLogic.labelIndex].layer.borderWidth = activeRow[GameLogic.labelIndex].layer.frame.height/20
        backButton.isEnabled = GameLogic.labelIndex == 0 ? false : true
        forwardButton.isEnabled = GameLogic.labelIndex == 4 ? false : true
    }
    
    func showCheckResults() {
        var index = 0
        var delay = 0.0
        
        for view in allAttempts[GameLogic.labelArrayIndex] {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                
                if GameLogic.checkResults[index] == 1 {
                    UIView.transition(with: view, duration: 0.7, options: .transitionFlipFromLeft) {
                        view.backgroundColor = .systemGray
                    }
                    UIView.transition(with: self.keyboard[index], duration: 0.7, options: .transitionCrossDissolve) {
                        self.colorKeysClear(view.text!)
                    }
                    
                } else if GameLogic.checkResults[index] == 2 {
                    UIView.transition(with: view, duration: 0.7, options: .transitionFlipFromLeft) {
                        view.backgroundColor = .systemYellow
                    }
                } else {
                    UIView.transition(with: view, duration: 0.7, options: .transitionFlipFromLeft) {
                        view.backgroundColor = .systemGreen
                    }
                    UIView.transition(with: self.keyboard[index], duration: 0.7, options: .transitionCrossDissolve) {
                        self.colorKeysGreen(view.text!)
                    }
                    
                }
                index += 1
            }
            delay += 0.18
        }
        resetLastBorder()
    }
    
    func colorKeysGreen(_ letter: String) {
        let keysToColor = keyboard.filter { UIButton in
            UIButton.currentTitle == letter
        }
        for key in keysToColor {
            key.backgroundColor = .systemGreen
        }
    }
    
    func colorKeysClear(_ letter: String) {
        let keysToColor = keyboard.filter { UIButton in
            UIButton.currentTitle == letter
        }
        for key in keysToColor {
            key.backgroundColor = .clear
        }
    }
}






