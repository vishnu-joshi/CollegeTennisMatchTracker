//
//  Scoreboard.swift
//  CollegeTennisTracker
//
//  Created by Vishnu Joshi on 5/27/19.
//  Copyright © 2019 Vishnu Joshi. All rights reserved.
//

import UIKit

class Scoreboard: UIViewController, WeatherFetcherDelegate, UITextFieldDelegate {
    
    var finalhometeam = CollegeTeam();
    var finalawayteam = CollegeTeam();
    let weatherFetcher = WeatherFetcher()
    var currscores = Scores()
    var scoreboard_helper = ScoreboardHelper()
    
    @IBOutlet weak var hometeamlabel: UILabel!
    @IBOutlet weak var awayteamlabel: UILabel!
    
    @IBOutlet weak var hometeamscore: UILabel!
    @IBOutlet weak var awayteamscore: UILabel!
    
    @IBOutlet weak var homed1: UILabel!
    @IBOutlet weak var awayd1: UILabel!
    @IBOutlet weak var homed2: UILabel!
    @IBOutlet weak var awayd2: UILabel!
    @IBOutlet weak var homed3: UILabel!
    @IBOutlet weak var awayd3: UILabel!
    @IBOutlet weak var homes1: UILabel!
    @IBOutlet weak var aways1: UILabel!
    @IBOutlet weak var homes2: UILabel!
    @IBOutlet weak var aways2: UILabel!
    @IBOutlet weak var homes3: UILabel!
    @IBOutlet weak var aways3: UILabel!
    @IBOutlet weak var homes4: UILabel!
    @IBOutlet weak var aways4: UILabel!
    @IBOutlet weak var homes5: UILabel!
    @IBOutlet weak var aways5: UILabel!
    @IBOutlet weak var homes6: UILabel!
    @IBOutlet weak var aways6: UILabel!
    
    @IBOutlet weak var homed1set1: UITextField!
    @IBOutlet weak var homed1set2: UITextField!
    @IBOutlet weak var homed1set3: UITextField!
    
    @IBOutlet weak var awayd1set1: UITextField!
    @IBOutlet weak var homed2set1: UITextField!
    @IBOutlet weak var awayd2set1: UITextField!
    
    @IBOutlet weak var homed3set1: UITextField!
    @IBOutlet weak var awayd3set1: UITextField!
    
    @IBOutlet weak var homes1set1: UITextField!
    @IBOutlet weak var homes1set2: UITextField!
    @IBOutlet weak var homes1set3: UITextField!
    @IBOutlet weak var aways1set1: UITextField!
    @IBOutlet weak var aways1set2: UITextField!
    @IBOutlet weak var aways1set3: UITextField!
    
    @IBOutlet weak var homes2set1: UITextField!
    @IBOutlet weak var homes2set2: UITextField!
    @IBOutlet weak var homes2set3: UITextField!
    @IBOutlet weak var aways2set1: UITextField!
    @IBOutlet weak var aways2set2: UITextField!
    @IBOutlet weak var aways2set3: UITextField!
    
    @IBOutlet weak var homes3set1: UITextField!
    @IBOutlet weak var homes3set2: UITextField!
    @IBOutlet weak var homes3set3: UITextField!
    @IBOutlet weak var aways3set1: UITextField!
    @IBOutlet weak var aways3set2: UITextField!
    @IBOutlet weak var aways3set3: UITextField!
    
    @IBOutlet weak var homes4set1: UITextField!
    @IBOutlet weak var homes4set2: UITextField!
    @IBOutlet weak var homes4set3: UITextField!
    @IBOutlet weak var aways4set1: UITextField!
    @IBOutlet weak var aways4set2: UITextField!
    @IBOutlet weak var aways4set3: UITextField!
    
    @IBOutlet weak var homes5set1: UITextField!
    @IBOutlet weak var homes5set2: UITextField!
    @IBOutlet weak var homes5set3: UITextField!
    
    @IBOutlet weak var aways5set1: UITextField!
    @IBOutlet weak var aways5set2: UITextField!
    @IBOutlet weak var aways5set3: UITextField!
    
    @IBOutlet weak var homes6set1: UITextField!
    @IBOutlet weak var homes6set2: UITextField!
    @IBOutlet weak var homes6set3: UITextField!
    
    @IBOutlet weak var aways6set1: UITextField!
    @IBOutlet weak var aways6set2: UITextField!
    @IBOutlet weak var aways6set3: UITextField!
    
    @IBOutlet weak var cityName: UITextField!
    
    @IBAction func cityNameEntered(_ sender: Any) {
        weatherFetcher.getWeather(cityName.text!)
    }
    
    @IBOutlet weak var temperatureValue: UILabel!
    
    func setWeather(weather: WeatherInfo) {
        temperatureValue.text = String(weather.temp);
    }
    
    func updateSinglesScore(_ sb: inout Scores, _ matchnum: Int, _ home: Bool, _ set1: UITextField, _ set2: UITextField, _ set3: UITextField) {
        if (sb.singlesMatches[matchnum]!.setscomplete == 0) {
            set1.text = scoreboard_helper.updateSetOne(&sb, matchnum, home)
        } else if (sb.singlesMatches[matchnum]!.setscomplete == 1) {
            set2.text = scoreboard_helper.updateSetTwo(&sb, matchnum, home)
        } else if (sb.singlesMatches[matchnum]!.setscomplete == 2 && !sb.singlesMatches[matchnum]!.matchcomplete) {
            set3.text = scoreboard_helper.updateSetThree(&sb, matchnum, home)
        }
        if (sb.singlesMatches[matchnum]!.matchcomplete) {
            return
        }
        if (scoreboard_helper.homeWins(&sb, matchnum)) {
            sb.hometotalcount += 1
            hometeamscore.text = String(sb.hometotalcount)
            sb.singlesMatches[matchnum]!.matchcomplete = true
        } else if (scoreboard_helper.awayWins(&sb, matchnum)) {
            sb.awaytotalcount += 1
            awayteamscore.text = String(sb.awaytotalcount)
            sb.singlesMatches[matchnum]!.matchcomplete = true
        }
    }
    
    func updateSinglesMinus(_ sb: inout Scores, _ matchnum: Int, _ home: Bool, _ set1: UITextField, _ set2: UITextField, _ set3: UITextField) {
        scoreboard_helper.subCompletedIfThird(&sb, matchnum, home)
        set3.text = scoreboard_helper.subSetThree(&sb, matchnum, home)
        scoreboard_helper.subCompletedIfSecond(&sb, matchnum, home)
        set2.text = scoreboard_helper.subSetTwo(&sb, matchnum, home)
        set1.text = scoreboard_helper.subSetOne(&sb, matchnum, home)
        hometeamscore.text = String(sb.hometotalcount)
        sb.singlesMatches[matchnum]!.matchcomplete = false
        awayteamscore.text = String(sb.awaytotalcount)
        sb.singlesMatches[matchnum]!.matchcomplete = false
    }
    
    func updateDoublesOnPlus(_ sb: inout Scores, _ matchnum: Int, _ home: Bool) {
        if (scoreboard_helper.dubsMatchCompleted(&sb, matchnum)) {
            return
        }
        if (home) {
            if sb.doublesMatches[matchnum]?.homescore != 8 {
                sb.doublesMatches[matchnum]?.homescore += 1
                if (sb.doublesMatches[matchnum]?.homescore == 8) {
                    sb.hometotalcount += 1
                    hometeamscore.text = String(sb.hometotalcount)
                }
            }
        } else {
            if sb.doublesMatches[matchnum]?.awayscore != 8 {
                sb.doublesMatches[matchnum]?.awayscore += 1
                if (sb.doublesMatches[matchnum]?.awayscore == 8) {
                    sb.awaytotalcount += 1
                    awayteamscore.text = String(sb.awaytotalcount)
                }
            }
        }
    }
    
    func updateDoublesOnMinus(_ sb: inout Scores, _ matchnum: Int, _ home: Bool) {
        if (home) {
            if sb.doublesMatches[matchnum]?.homescore != 0 {
                if (sb.doublesMatches[matchnum]?.homescore == 8) {
                    sb.hometotalcount -= 1
                    hometeamscore.text = String(sb.hometotalcount)

                }
                sb.doublesMatches[matchnum]?.homescore -= 1
            }
        } else {
            if sb.doublesMatches[matchnum]?.awayscore != 0 {
                if (sb.doublesMatches[matchnum]?.awayscore == 8) {
                    sb.awaytotalcount -= 1
                    awayteamscore.text = String(sb.awaytotalcount)
                }
                sb.doublesMatches[matchnum]?.awayscore -= 1
            }
        }
    }
    
    @IBAction func homedplus(_ sender: Any) {
        updateDoublesOnPlus(&currscores, 0, true)
        homed1set1.text = String(currscores.doublesMatches[0]!.homescore)
    }
    
    @IBAction func homedminus(_ sender: Any) {
        updateDoublesOnMinus(&currscores, 0, true)
        homed1set1.text = String(currscores.doublesMatches[0]!.homescore)
    }
    
    @IBAction func awaydplus(_ sender: Any) {
        updateDoublesOnPlus(&currscores, 0, false)
        awayd1set1.text = String(currscores.doublesMatches[0]!.awayscore)
    }
    
    @IBAction func awaydminus(_ sender: Any) {
        updateDoublesOnMinus(&currscores, 0, false)
        awayd1set1.text = String(currscores.doublesMatches[0]!.awayscore)
    }
    
    @IBAction func homed2plus(_ sender: Any) {
        updateDoublesOnPlus(&currscores, 1, true)
        homed2set1.text = String(currscores.doublesMatches[1]!.homescore)
    }
    
    @IBAction func homed2minus(_ sender: Any) {
        updateDoublesOnMinus(&currscores, 1, true)
        homed2set1.text = String(currscores.doublesMatches[1]!.homescore)
    }
    
    @IBAction func awayd2plus(_ sender: Any) {
        updateDoublesOnPlus(&currscores, 1, false)
        awayd2set1.text = String(currscores.doublesMatches[1]!.awayscore)
    }
    @IBAction func awayd2minus(_ sender: Any) {
        updateDoublesOnMinus(&currscores, 1, false)
        awayd2set1.text = String(currscores.doublesMatches[1]!.awayscore)
    }
    
    @IBAction func homed3plus(_ sender: Any) {
        updateDoublesOnPlus(&currscores, 2, true)
        homed3set1.text = String(currscores.doublesMatches[2]!.homescore)
    }
    
    @IBAction func homed3minus(_ sender: Any) {
        updateDoublesOnMinus(&currscores, 2, true)
        homed3set1.text = String(currscores.doublesMatches[2]!.homescore)
    }
    
    @IBAction func awayd3plus(_ sender: Any) {
        updateDoublesOnPlus(&currscores, 2, false)
        awayd3set1.text = String(currscores.doublesMatches[2]!.awayscore)
    }
    
    @IBAction func awayd3minus(_ sender: Any) {
        updateDoublesOnMinus(&currscores, 2, false)
        awayd3set1.text = String(currscores.doublesMatches[2]!.awayscore)
    }
    
    @IBAction func homes1plus(_ sender: Any) {
        updateSinglesScore(&currscores, 0, true, homes1set1, homes1set2, homes1set3)
    }
    
    @IBAction func homes1minus(_ sender: Any) {
        updateSinglesMinus(&currscores, 0, true, homes1set1, homes1set2, homes1set3)
    }
    
    
    @IBAction func aways1plus(_ sender: Any) {
        updateSinglesScore(&currscores, 0, false, aways1set1, aways1set2, aways1set3)
    }
    
    @IBAction func aways1minus(_ sender: Any) {
        updateSinglesMinus(&currscores, 0, false, aways1set1, aways1set2, aways1set3)
    }
    
    
    @IBAction func homes2plus(_ sender: Any) {
        updateSinglesScore(&currscores, 1, true, homes2set1, homes2set2, homes2set3)
    }
    
    
    @IBAction func homes2minus(_ sender: Any) {
        updateSinglesMinus(&currscores, 1, true, homes2set1, homes2set2, homes2set3)
    }
    
    
    @IBAction func aways2plus(_ sender: Any) {
        updateSinglesScore(&currscores, 1, false, aways2set1, aways2set2, aways2set3)
    }
    
    
    @IBAction func aways2minus(_ sender: Any) {
        updateSinglesMinus(&currscores, 1, false, aways2set1, aways2set2, aways2set3)
    }
    
    
    @IBAction func homes3plus(_ sender: Any) {
        updateSinglesScore(&currscores, 2, true, homes3set1, homes3set2, homes3set3)
    }
    
    
    @IBAction func homes3minus(_ sender: Any) {
        updateSinglesMinus(&currscores, 2, true, homes3set1, homes3set2, homes3set3)
    }
    
    
    @IBAction func aways3plus(_ sender: Any) {
        updateSinglesScore(&currscores, 2, false, aways3set1, aways3set2, aways3set3)
    }
    
    
    @IBAction func aways3minus(_ sender: Any) {
        updateSinglesMinus(&currscores, 2, false, aways3set1, aways3set2, aways3set3)
    }
    
    
    @IBAction func homes4plus(_ sender: Any) {
        updateSinglesScore(&currscores, 3, true, homes4set1, homes4set2, homes4set3)
    }
    
    
    @IBAction func homes4minus(_ sender: Any) {
        updateSinglesMinus(&currscores, 3, true, homes4set1, homes4set2, homes4set3)
    }
    
    
    @IBAction func aways4plus(_ sender: Any) {
        updateSinglesScore(&currscores, 3, false, aways4set1, aways4set2, aways4set3)
    }
    
    @IBAction func aways4minus(_ sender: Any) {
        updateSinglesMinus(&currscores, 3, false, aways4set1, aways4set2, aways4set3)
    }
    
    
    @IBAction func homes5plus(_ sender: Any) {
        updateSinglesScore(&currscores, 4, true, homes5set1, homes5set2, homes5set3)
    }
    
    @IBAction func homes5minus(_ sender: Any) {
        updateSinglesMinus(&currscores, 4, true, homes5set1, homes5set2, homes5set3)
    }
    
    
    @IBAction func aways5plus(_ sender: Any) {
        updateSinglesScore(&currscores, 4, false, aways5set1, aways5set2, aways5set3)
    }
    
    @IBAction func aways5minus(_ sender: Any) {
        updateSinglesMinus(&currscores, 4, false, aways5set1, aways5set2, aways5set3)
    }
    
    @IBAction func homes6plus(_ sender: Any) {
        updateSinglesScore(&currscores, 5, true, homes6set1, homes6set2, homes6set3)
    }
    
    @IBAction func homes6minus(_ sender: Any) {
        updateSinglesMinus(&currscores, 5, true, homes6set1, homes6set2, homes6set3)
    }
    
    @IBAction func aways6plus(_ sender: Any) {
        updateSinglesScore(&currscores, 5, false, aways6set1, aways6set2, aways6set3)
    }
    
    @IBAction func aways6minus(_ sender: Any) {
        updateSinglesMinus(&currscores, 5, false, aways6set1, aways6set2, aways6set3)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hometeamlabel.text = self.finalhometeam.name;
        awayteamlabel.text = self.finalawayteam.name;
        
        homed1.text = self.finalhometeam.doubles_teams[0]
        homed2.text = self.finalhometeam.doubles_teams[1]
        homed3.text = self.finalhometeam.doubles_teams[2]
        homes1.text = self.finalhometeam.singles_teams[0]
        homes2.text = self.finalhometeam.singles_teams[1]
        homes3.text = self.finalhometeam.singles_teams[2]
        homes4.text = self.finalhometeam.singles_teams[3]
        homes5.text = self.finalhometeam.singles_teams[4]
        homes6.text = self.finalhometeam.singles_teams[5]
        
        awayd1.text = self.finalawayteam.doubles_teams[0]
        awayd2.text = self.finalawayteam.doubles_teams[1]
        awayd3.text = self.finalawayteam.doubles_teams[2]
        aways1.text = self.finalawayteam.singles_teams[0]
        aways2.text = self.finalawayteam.singles_teams[1]
        aways3.text = self.finalawayteam.singles_teams[2]
        aways4.text = self.finalawayteam.singles_teams[3]
        aways5.text = self.finalawayteam.singles_teams[4]
        aways6.text = self.finalawayteam.singles_teams[5]
 
        self.weatherFetcher.delegate = self;
        // Do any additional setup after loading the view.
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
