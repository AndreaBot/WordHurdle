//
//  PlayerStats.swift
//  WordHurdle
//
//  Created by Andrea Bottino on 07/11/2023.
//

import Foundation

class PlayerStats: StatsManagerProtocol {
    
    var stats = [
        Stat(name: StatsNames.gamesPlayed, value: 0, isIncludedInChart: false),
        Stat(name: StatsNames.gamesWon, value: 0, isIncludedInChart: false),
        Stat(name: StatsNames.currentStreak, value: 0, isIncludedInChart: false),
        Stat(name: StatsNames.maxStreak, value: 0, isIncludedInChart: false),
        Stat(name: StatsNames.winsIn1, value: 0, isIncludedInChart: true),
        Stat(name: StatsNames.winsIn2, value: 0, isIncludedInChart: true),
        Stat(name: StatsNames.winsIn3, value: 0, isIncludedInChart: true),
        Stat(name: StatsNames.winsIn4, value: 0, isIncludedInChart: true),
        Stat(name: StatsNames.winsIn5, value: 0, isIncludedInChart: true),
        Stat(name: StatsNames.winsIn6, value: 0, isIncludedInChart: true)
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
    
    func indexForStat(named: String) -> Int? {
        if let index = stats.firstIndex(where: { $0.name == named }) {
            return index
        } else {
            return nil
        }
    }
    
    func setGuessDistribution(index: Int) {
        if let winsIn1Index = indexForStat(named: StatsNames.winsIn1),
           let winsIn2Index = indexForStat(named: StatsNames.winsIn2),
           let winsIn3Index = indexForStat(named: StatsNames.winsIn3),
           let winsIn4Index = indexForStat(named: StatsNames.winsIn4),
           let winsIn5Index = indexForStat(named: StatsNames.winsIn5),
           let winsIn6Index = indexForStat(named: StatsNames.winsIn6) {
            
            switch index {
            case 0: stats[winsIn1Index].value += 1
            case 1: stats[winsIn2Index].value += 1
            case 2: stats[winsIn3Index].value += 1
            case 3: stats[winsIn4Index].value += 1
            case 4: stats[winsIn5Index].value += 1
            case 5: stats[winsIn6Index].value += 1
            default: break
            }
        }
    }
    
    func setStatsForGameWon() {
        if let gamesPlayedIndex = indexForStat(named: StatsNames.gamesPlayed),
           let gamesWonIndex = indexForStat(named: StatsNames.gamesWon),
           let currentStreakIndex = indexForStat(named: StatsNames.currentStreak),
           let maxStreakIndex = indexForStat(named: StatsNames.maxStreak) {
            
            stats[gamesPlayedIndex].value += 1
            stats[gamesWonIndex].value += 1
            stats[currentStreakIndex].value += 1
            
            if stats[currentStreakIndex].value > stats[maxStreakIndex].value {
                stats[maxStreakIndex].value = stats[currentStreakIndex].value
            }
            
        } else {
            print("Error: One or more stats were not found.")
        }
    }
    
    func setStatsForGameLost() {
        if let gamesPlayedIndex = indexForStat(named: StatsNames.gamesPlayed),
           let currentStreakIndex = indexForStat(named: StatsNames.currentStreak) {
            
            stats[gamesPlayedIndex].value += 1
            stats[currentStreakIndex].value = 0
        }
    }
}
