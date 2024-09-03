//
//  PlayerStats.swift
//  WordHurdle
//
//  Created by Andrea Bottino on 07/11/2023.
//

import Foundation

class PlayerStats: StatsManagerProtocol {
    
    var stats = [
        Stat(name: "Games played", value: 0, isIncludedInChart: false),
        Stat(name: "Wins", value: 0, isIncludedInChart: false),
        Stat(name: "Current streak", value: 0, isIncludedInChart: false),
        Stat(name: "Max streak", value: 0, isIncludedInChart: false),
        Stat(name: "Win in 1", value: 0, isIncludedInChart: true),
        Stat(name: "Win in 2", value: 0, isIncludedInChart: true),
        Stat(name: "Win in 3", value: 0, isIncludedInChart: true),
        Stat(name: "Win in 4", value: 0, isIncludedInChart: true),
        Stat(name: "Win in 5", value: 0, isIncludedInChart: true),
        Stat(name: "Win in 6", value: 0, isIncludedInChart: true)
    ] {
        didSet {
            saveStats()
        }
    }
    
    func saveStats() {
        do {
            let encodedData = try JSONEncoder().encode(stats)
            UserDefaults.standard.setValue(encodedData, forKey: "stats")
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func loadStats() {
        if let allStats = UserDefaults.standard.object(forKey: "stats") {
            do {
                let decodedData = try JSONDecoder().decode([Stat].self, from: allStats as! Data )
                stats = decodedData
                
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    func setGuessDistribution(index: Int) {
        switch index {
        case 0: stats[4].value += 1
        case 1: stats[5].value += 1
        case 2: stats[6].value += 1
        case 3: stats[7].value += 1
        case 4: stats[8].value += 1
        case 5: stats[9].value += 1
        default: stats[4].value += 0
        }
    }
    
    func setStatsForGameWon() {
       stats[0].value += 1
       stats[1].value += 1
       stats[2].value += 1
        if stats[2].value > stats[3].value {
            stats[3].value = stats[2].value
        }
    }
    
    func setStatsForGameLost() {
        stats[0].value += 1
        stats[2].value = 0
    }
}
