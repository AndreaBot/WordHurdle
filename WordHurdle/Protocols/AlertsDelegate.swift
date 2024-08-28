//
//  AlertsDelegate.swift
//  WordHurdle
//
//  Created by Andrea Bottino on 28/08/2024.
//

import Foundation

protocol AlertsDelegate {
    func showEndMessage(title: String, message: String)
    func showNonExistentWordAlert(_ word: String)
}
