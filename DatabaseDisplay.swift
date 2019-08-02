//
//  ViewController.swift
//  CollegeTennisTracker
//
//  Created by Vishnu Joshi on 5/27/19.
//  Copyright © 2019 Vishnu Joshi. All rights reserved.
//

import UIKit

class DatabaseDisplay: UIViewController, DatabaseDisplayDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var matchTable: UITableView!
    var historicmatches = [CompletedMatch]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historicmatches.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "initcell", for: indexPath)
        let celldisplaystring = historicmatches[indexPath.row].home_team_name + " vs. " + historicmatches[indexPath.row].away_team_name
        cell.textLabel?.text = celldisplaystring
        return cell
    }
    
    
    
    func matchesDownlaoded(completedMatches: [CompletedMatch]) {
        self.historicmatches = completedMatches
        DispatchQueue.main.async {
            self.matchTable.reloadData()
        }
    }
    

    var fetchdata = CompletedMatchDataFetcher()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //initiate calling items download
        fetchdata.getItems()
        fetchdata.delegate = self
        matchTable.delegate = self
        matchTable.dataSource = self
        
    }


}

