//
//  StatsViewController.swift
//  WordHurdle
//
//  Created by Andrea Bottino on 07/11/2023.
//

import UIKit

class StatsViewController: UIViewController {
    
    @IBOutlet weak var statsTableView: UITableView!
    
    var statArray = [Stat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statsTableView.delegate = self
        statsTableView.dataSource = self
        statsTableView.register(UINib(nibName: "StatTableViewCell", bundle: nil), forCellReuseIdentifier: "statCell")
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
        
        return cell
    }
    
    
    
    
}
