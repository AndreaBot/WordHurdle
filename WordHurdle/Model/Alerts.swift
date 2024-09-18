//
//  Alerts.swift
//  WordHurdle
//
//  Created by Andrea Bottino on 02/11/2023.
//

import UIKit

struct Alerts {
    
    static func endGameAlert(_ title: String, _ message: String, _ newGameFunc: @escaping () -> Void) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "New Game", style: .default, handler: { UIAlertAction in
            newGameFunc()
        }))
        return alert
    }
    
    static func timedAlert(_ guess: String) -> UIAlertController {
        let alert = UIAlertController(title: "Try again", message: "\(guess.uppercased()) is not a valid word", preferredStyle: .actionSheet)
        alert.view.accessibilityIdentifier = "timedAlert"
        return alert
    }
}



