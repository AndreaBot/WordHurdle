//
//  StatsManager.swift
//  WordHurdle
//
//  Created by Andrea Bottino on 29/08/2024.
//

import Foundation

protocol StatsManagerProtocol {
    var stats: [Stat] { get set }
    func setGuessDistribution(index: Int)
    func saveStats()
    func loadStats()
}
