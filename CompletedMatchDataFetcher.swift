//
//  CompletedMatchDisplayView.swift
//  CollegeTennisTracker
//
//  Created by Vishnu Joshi on 6/26/19.
//  Copyright © 2019 Vishnu Joshi. All rights reserved.
//

import UIKit

protocol DatabaseDisplayDelegate {
    
    func matchesDownlaoded(completedMatches:[CompletedMatch] )
    
}

class CompletedMatchDataFetcher: NSObject {
    
    var delegate:DatabaseDisplayDelegate?
    func getItems() {
        let serviceUrl = "http://owlfocus.net/service.php"
        
        let url = URL(string: serviceUrl)
        
        
        if let url = url {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    //succeeded
                    self.parseJson(data: data!)
                } else {
                    print("There was an error loading the data. Try checking your connection or your credentials.")
                }
            }
            
            task.resume()
        }
    }
    
    func parseJson(data:Data) {
        
        var compMatchArray = [CompletedMatch]()
        do {
            let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as! [Any]
            
            for jsonres in jsonArray {
                let jsondict = jsonres as! [String:String]
                let home_wins = (jsondict["home_wins"] == "0") ? false : true
                let is_indoors = (jsondict["is_indoors"] == "0") ? false : true
                let compMatch = CompletedMatch(home_team_name: jsondict["home_team"]!, away_team_name: jsondict["away_team"]!, homeWins: home_wins, isIndoors: is_indoors)
                compMatchArray.append(compMatch)
            }
            
        }
        catch {
            
        }
        delegate?.matchesDownlaoded(completedMatches: compMatchArray)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
