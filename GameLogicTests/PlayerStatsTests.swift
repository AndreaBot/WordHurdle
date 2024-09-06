//
//  PlayerStatsTests.swift
//  GameLogicTests
//
//  Created by Andrea Bottino on 06/09/2024.
//

import XCTest
@testable import WordHurdle


final class PlayerStatsTests: XCTestCase {
    
    var playerStats: PlayerStats!

    override func setUpWithError() throws {
        playerStats = PlayerStats()
    }

    override func tearDownWithError() throws {
        playerStats = nil
    }
    
    func test_setGuessDistribution_setsValue() {
        // GIVEN
        let initialValue = playerStats.stats[4].value
        
        // WHEN
        playerStats.setGuessDistribution(index: 0)
        
        // THEN
        XCTAssertEqual(playerStats.stats[4].value, initialValue + 1, "The stat was not increased in value")
    }
    
    
}
