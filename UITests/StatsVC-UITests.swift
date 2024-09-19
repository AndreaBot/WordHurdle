//
//  StatsVC-UITests.swift
//  UITests
//
//  Created by Andrea Bottino on 19/09/2024.
//

import XCTest

final class StatsVC_UITests: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
    }
    
    func testStatsViewAppears() {
        let app = launchApp()
        app.buttons["showStatsButton"].tap()
        XCTAssertTrue(app.otherElements["statsVC"].waitForExistence(timeout: 2), "The stats screen was not presented")
    }
    
    func testStatsScreenHasBasicStats() {
        let app = launchApp()
        app.buttons["showStatsButton"].tap()
        XCTAssertTrue(app.cells["Games played"].waitForExistence(timeout: 2), "The stat for games played is not shown")
        XCTAssertTrue(app.cells["Wins"].waitForExistence(timeout: 2), "The stat for games won is not shown")
        XCTAssertTrue(app.cells["Current streak"].waitForExistence(timeout: 2), "The stat for the current streak is not shown")
        XCTAssertTrue(app.cells["Longest streak"].waitForExistence(timeout: 2), "The stat for the longest streak is not shown")
    }
    
    func testStatsIncludesChartView() {
        let app = launchApp()
        app.buttons["showStatsButton"].tap()
        XCTAssertTrue(app.otherElements["chartView"].waitForExistence(timeout: 2), "The chart is not being shown")
    }
    
    func testStatsScreenGetsDismissed() {
        let app = launchApp()
        app.buttons["showStatsButton"].tap()
        XCTAssertTrue(app.otherElements["statsVC"].waitForExistence(timeout: 2))
        app.buttons["dismissStatsButton"].tap()
        XCTAssertFalse(app.otherElements["statsVC"].waitForExistence(timeout: 2), "The stats screen was not dismissed")
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func launchApp() -> XCUIApplication {
        let app = XCUIApplication()
        app.launch()
        return app
    }
}
