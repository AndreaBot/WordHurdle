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
        Stat(name: "Test", value: 99, isIncludedInChart: true)
        
    ]
}
