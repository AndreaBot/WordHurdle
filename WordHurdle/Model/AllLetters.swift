//
//  AllLetters.swift
//  WordHurdle
//
//  Created by Andrea Bottino on 29/10/2023.
//

import Foundation

class AllLetters {
    
    var letters = [
        "A": 0,
        "B": 0,
        "C": 0,
        "D": 0,
        "E": 0,
        "F": 0,
        "G": 0,
        "H": 0,
        "I": 0,
        "J": 0,
        "K": 0,
        "L": 0,
        "M": 0,
        "N": 0,
        "O": 0,
        "P": 0,
        "Q": 0,
        "R": 0,
        "S": 0,
        "T": 0,
        "U": 0,
        "V": 0,
        "W": 0,
        "X": 0,
        "Y": 0,
        "Z": 0
    ]
    
    func addCounter(_ letter: String) {
        letters[letter]! += 1
    }
    
    func resetCounters() {
        for (letter, _) in letters {
            letters[letter] = 0
        }
    }
    
    func setupAllCounters(word: String) {
        for character in word {
           letters[String(character)]! += 1
        }
    }
}

