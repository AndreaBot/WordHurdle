//
//  StatsViewController.swift
//  WordHurdle
//
//  Created by Andrea Bottino on 07/11/2023.
//

import UIKit
import AnyChartiOS

class StatsViewController: UIViewController {
    
    @IBOutlet weak var statsTableView: UITableView!
    @IBOutlet weak var chartContainerView: UIView!
    @IBOutlet weak var chartView: UIView!
    
    var statArray = [Stat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statsTableView.delegate = self
        statsTableView.dataSource = self
        statsTableView.register(UINib(nibName: "StatTableViewCell", bundle: nil), forCellReuseIdentifier: "statCell")
        setupChartView()
    }
    
    func setupChartView() {
        chartView.addSubview(AnyChartiOS.createChart(view))
        chartView.subviews[0].translatesAutoresizingMaskIntoConstraints = false
        chartView.subviews[0].centerXAnchor.constraint(equalTo: chartView.centerXAnchor).isActive = true
        chartView.subviews[0].centerYAnchor.constraint(equalTo: chartView.centerYAnchor).isActive = true
        chartView.subviews[0].widthAnchor.constraint(equalTo: chartView.widthAnchor).isActive = true
        chartView.subviews[0].heightAnchor.constraint(equalTo: chartView.heightAnchor).isActive = true
        chartContainerView.clipsToBounds = true
        chartContainerView.layer.cornerRadius = chartView.frame.height/30
    }
}

//MARK: - TableViewDelegate & DataSource

extension StatsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        statArray = PlayerStats.stats.filter({ Stat in
            Stat.isIncludedInChart == false
        })
        
        return statArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "statCell", for: indexPath) as! StatTableViewCell
        
        cell.statNameLabel.text = statArray[indexPath.row].name
        cell.statValueLabel.text = String(statArray[indexPath.row].value)
        cell.backgroundColor = .clear
        
        return cell
    }
}
