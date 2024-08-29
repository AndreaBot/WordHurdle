//
//  PlayerStats.swift
//  WordHurdle
//
//  Created by Andrea Bottino on 07/11/2023.
//

import Foundation

class PlayerStats: StatsManagerProtocol {
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appending(path: "Stats.plist")
    
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
    ]
    
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
    
    func saveStats() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(stats)
            try data.write(to: dataFilePath!)
        } catch {
            print("error encoding item array, \(error)")
        }
    }
    
    func loadStats() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                stats = try decoder.decode([Stat].self, from: data)
            } catch {
                print("error decoding item array, \(error)")
            }
        }
    }
    
    
}
