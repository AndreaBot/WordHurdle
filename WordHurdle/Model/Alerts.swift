//
//  Alerts.swift
//  WordHurdle
//
//  Created by Andrea Bottino on 02/11/2023.
//

import UIKit

struct Alerts {
    
    static func endGameAlert(_ VC: UIViewController, _ title: String, _ message: String, _ newGameFunc: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "New Game", style: .default, handler: { UIAlertAction in
            newGameFunc()
        }))
        VC.present(alert, animated: true)
    }
    
    static func timedAlert(_ VC: UIViewController, _ guess: String) {
        let alert = UIAlertController(title: "Try again", message: "\(guess.uppercased()) is not a valid word", preferredStyle: .actionSheet)
        VC.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            VC.dismiss(animated: true)
        }
    }
}



