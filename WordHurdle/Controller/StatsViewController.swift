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

    var playerStats: StatsManagerProtocol? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        statsTableView.delegate = self
        statsTableView.dataSource = self
        statsTableView.register(UINib(nibName: "StatTableViewCell", bundle: nil), forCellReuseIdentifier: "statCell")
        setupChartView()
        playerStats?.loadStats()
        view.accessibilityIdentifier = "statsVC"
    }
    
    func setupChartView() {
        chartView.addSubview(AnyChartiOS.createChart(playerStats: playerStats ?? PlayerStats()))
        chartView.subviews[0].translatesAutoresizingMaskIntoConstraints = false
        chartView.subviews[0].centerXAnchor.constraint(equalTo: chartView.centerXAnchor).isActive = true
        chartView.subviews[0].centerYAnchor.constraint(equalTo: chartView.centerYAnchor).isActive = true
        chartView.subviews[0].widthAnchor.constraint(equalTo: chartView.widthAnchor).isActive = true
        chartView.subviews[0].heightAnchor.constraint(equalTo: chartView.heightAnchor).isActive = true
        chartContainerView.clipsToBounds = true
        chartContainerView.layer.cornerRadius = chartView.frame.height/30
        chartView.accessibilityIdentifier = "chartView"
    }
    
    @IBAction func dismissStatsView(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}

//MARK: - TableViewDelegate & DataSource

extension StatsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let playerStats = playerStats {
            return playerStats.stats.filter { stat in
                stat.isIncludedInChart == false
            }.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "statCell", for: indexPath) as! StatTableViewCell
        if let playerStats = playerStats {
            let filtered = playerStats.stats.filter { stat in
                stat.isIncludedInChart == false
            }
            cell.statNameLabel.text = filtered[indexPath.row].name
           
            cell.statValueLabel.text = String(filtered[indexPath.row].value)
            cell.backgroundColor = .clear
            cell.accessibilityIdentifier = filtered[indexPath.row].name
        }
        return cell
    }
}
