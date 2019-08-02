//
//  Scores.swift
//  CollegeTennisTracker
//
//  Created by Vishnu Joshi on 6/18/19.
//  Copyright © 2019 Vishnu Joshi. All rights reserved.
//

import Foundation

struct Scores {
    
    struct doublesMatch {
        var homescore:Int = 0
        var awayscore:Int = 0
    }
    
    struct singlesMatch {
        var homefirst:Int = 0;
        var homesecond:Int = 0;
        var homethird:Int = 0;
        var awayfirst:Int = 0;
        var awaysecond:Int = 0;
        var awaythird:Int = 0;
        var homesets:Int = 0;
        var awaysets:Int = 0;
        var setscomplete:Int = 0;
        var matchcomplete:Bool = false;
    }
    
    var doublesMatches = [doublesMatch?](repeating: doublesMatch(), count: 3)
    var singlesMatches = [singlesMatch?](repeating: singlesMatch(), count: 6)
    var hometotalcount:Int = 0
    var awaytotalcount:Int = 0
}
