//
//  PlayerStats.swift
//  WordHurdle
//
//  Created by Andrea Bottino on 07/11/2023.
//

import Foundation

struct PlayerStats {
    
    static var stats = [
        
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
}
