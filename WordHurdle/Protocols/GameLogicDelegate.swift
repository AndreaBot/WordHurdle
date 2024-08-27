//
//  GameLogicDelegate.swift
//  WordHurdle
//
//  Created by Andrea Bottino on 27/08/2024.
//

import Foundation

protocol GameLogicDelegate {
    func enableKeyboard()
    func disableKeyboard()
    func resetBoxes()
    func setBordersAndNavButtons()
    func showCheckResults()
    func showEndMessage(title: String, message: String)
    func showNonExistentWordAlert(_ word: String)
}