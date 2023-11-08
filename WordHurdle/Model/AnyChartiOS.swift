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
        
        view.addSubview(anyChartView)
        anyChartView.translatesAutoresizingMaskIntoConstraints = false
        anyChartView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        anyChartView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        anyChartView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        anyChartView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        let chart = AnyChart.column()
        
        let data: Array<DataEntry> = [
            ValueDataEntry(x: "1", value: PlayerStats.stats[4].value),
            ValueDataEntry(x: "2", value: PlayerStats.stats[5].value),
            ValueDataEntry(x: "3", value: PlayerStats.stats[6].value),
            ValueDataEntry(x: "4", value: PlayerStats.stats[7].value),
            ValueDataEntry(x: "5", value: PlayerStats.stats[8].value),
            ValueDataEntry(x: "6", value: PlayerStats.stats[9].value),
            
        ]
        
        let column = chart.column(data: data)
        
        column.tooltip()
            .titleFormat(format: "{%X}")
            .title(settings: false)
            .position(position: anychart.enums.Position.CENTER_BOTTOM)
            .anchor(anchor: anychart.enums.Anchor.CENTER_BOTTOM)
            .offsetX(offset: 0)
            .offsetY(offset: 5)
            .format(format: "{%Value}{groupsSeparator: }")
        
       chart.animation(settings: true)
       
       chart.yScale().minimum(minimum: 0)
        chart.yScale().maximumGap(gap: 1.0)
        
        chart.background().fill(color: "White", opacity: 1)
       // chart.dataArea().background().fill(color: "gold", opacity: 0)
       
        
        
        //chart.yAxis(index: 0).labels().format(token: "${%Value}{groupsSeparator: }")
        
        chart.tooltip().positionMode(mode: anychart.enums.TooltipPositionMode.POINT)
       //chart.interactivity().hoverMode(mode: anychart.enums.HoverMode.BY_X)
       
        
        anyChartView.setChart(chart: chart)
        return anyChartView
    }
    
    static func setBackground(_ view: UIView) -> String {
        
        if view.traitCollection.userInterfaceStyle == .dark {
                    return "black"
                } else {
                    return "white"
                }

    }
    
    
}
