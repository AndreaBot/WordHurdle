//
//  StatsManager.swift
//  WordHurdle
//
//  Created by Andrea Bottino on 29/08/2024.
//

import Foundation

protocol StatsManagerProtocol {
    var stats: [Stat] { get set }
    func saveStats()
    func loadStats()
    func setGuessDistribution(index: Int)
    func setStatsForGameWon()
    func setStatsForGameLost()
}
