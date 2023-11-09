//
//  AnyChartiOS.swift
//  WordHurdle
//
//  Created by Andrea Bottino on 08/11/2023.
//

import UIKit
import AnyChartiOS

struct AnyChartiOS {
    
    static func createChart(_ view: UIView) -> AnyChartView {
        
        let anyChartView = AnyChartView()
        
        let chart = AnyChart.column()
        _ = chart.animation(settings: true)
        _ = chart.interactivity(settings: "none")
        _ = chart.yScale().maximumGap(gap: 1.0)
        
        let data: Array<DataEntry> = [
            ValueDataEntry(x: "1", value: PlayerStats.stats[4].value),
            ValueDataEntry(x: "2", value: PlayerStats.stats[5].value),
            ValueDataEntry(x: "3", value: PlayerStats.stats[6].value),
            ValueDataEntry(x: "4", value: PlayerStats.stats[7].value),
            ValueDataEntry(x: "5", value: PlayerStats.stats[8].value),
            ValueDataEntry(x: "6", value: PlayerStats.stats[9].value),
        ]
        
        let column = chart.column(data: data)
        _ = column.tooltip()
        _ = column.tooltip().title(settings: false)
        _ = column.fill(color: "dodgerblue", opacity: 1)
        _ = column.stroke(settings: "disabled")
        _ = column.tooltip().enabled(enabled: false)
        _ = column.selectionMode(value: anychart.enums.SelectionMode.NONE)

        anyChartView.setChart(chart: chart)
        
        return anyChartView
    }
}
