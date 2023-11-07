//
//  Stat.swift
//  WordHurdle
//
//  Created by Andrea Bottino on 07/11/2023.
//

import Foundation

struct Stat: Codable {
    
    let name: String
    var value: Int
    let isIncludedInChart: Bool
}
