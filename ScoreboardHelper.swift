//
//  ScoreboardHelper.swift
//  CollegeTennisTracker
//
//  Created by Vishnu Joshi on 6/28/19.
//  Copyright © 2019 Vishnu Joshi. All rights reserved.
//

import Foundation

class ScoreboardHelper : NSObject {
    
    /*
     Function returning a boolean indicating whether or not a specified match is over (singles). Used for updating
     total match score.
     */
    func homeWins(_ sb: inout Scores, _ matchnum: Int) -> Bool {
        if sb.singlesMatches[matchnum]!.setscomplete < 2 {
            return false;
        }
        if sb.singlesMatches[matchnum]!.homesets == 2 {
            return true;
        }
        return false;
    }
    
    func awayWins(_ sb: inout Scores, _ matchnum: Int) -> Bool {
        if sb.singlesMatches[matchnum]!.setscomplete < 2 {
            return false;
        }
        if sb.singlesMatches[matchnum]!.awaysets == 2 {
            return true;
        }
        return false;
    }
    
    /*
     Returns boolean, true if set is over, false if set is not over, on a specified singles court.
    */
    func setIsOver(_ sb: inout Scores, _ matchnum: Int, _ setnum: Int) -> Bool {
        var home = 0;
        var away = 0;
        if setnum == 1 {
            home = sb.singlesMatches[matchnum]!.homefirst
            away = sb.singlesMatches[matchnum]!.awayfirst
        } else if setnum == 2 {
            home = sb.singlesMatches[matchnum]!.homesecond
            away = sb.singlesMatches[matchnum]!.awaysecond
        } else {
            home = sb.singlesMatches[matchnum]!.homethird
            away = sb.singlesMatches[matchnum]!.awaythird
        }
        if (max(home, away) < 6) {
            return false
        } else if ((max(home, away) - min(home, away)) > 1) {
            return true
        }
        return false
    }
    
    /*
     Returns boolean, true if doubles match is completed, false if not completed (first to 8 games, DIII)
     */
    func dubsMatchCompleted(_ sb: inout Scores, _ matchnum: Int) -> Bool {
        if (sb.doublesMatches[matchnum]?.homescore == 8 || sb.doublesMatches[matchnum]?.awayscore == 8) {
            return true
        }
        return false
        //TODO: Allow for D1 rules to be integrated
    }
    
    /*
     Returns a string for new updated first set score (if change adheres to rules)
    */
    func subSetOne(_ sb: inout Scores, _ matchnum: Int, _ home: Bool) -> String {
        if home {
            if (sb.singlesMatches[matchnum]!.setscomplete == 0) {
                if (sb.singlesMatches[matchnum]!.awayfirst == 7 && sb.singlesMatches[matchnum]!.homefirst < 6) {
                    sb.singlesMatches[matchnum]!.setscomplete += 1
                    return String(sb.singlesMatches[matchnum]!.homefirst)
                }
                if (sb.singlesMatches[matchnum]!.homefirst == 0) {
                    return String(0)
                }
                sb.singlesMatches[matchnum]!.homefirst -= 1
                if setIsOver(&sb, matchnum, 1) {
                    sb.singlesMatches[matchnum]!.awaysets += 1
                    sb.singlesMatches[matchnum]!.setscomplete += 1
                }
            }
            return String(sb.singlesMatches[matchnum]!.homefirst)
        } else {
            if (sb.singlesMatches[matchnum]!.setscomplete == 0) {
                if (sb.singlesMatches[matchnum]!.homefirst == 7 && sb.singlesMatches[matchnum]!.awayfirst < 6) {
                    return String(sb.singlesMatches[matchnum]!.awayfirst)
                }
                if (sb.singlesMatches[matchnum]!.awayfirst == 0) {
                    return String(0)
                }
                sb.singlesMatches[matchnum]!.awayfirst -= 1
                if setIsOver(&sb, matchnum, 1) {
                    sb.singlesMatches[matchnum]!.homesets += 1
                    sb.singlesMatches[matchnum]!.setscomplete += 1
                }
            }
            return String(sb.singlesMatches[matchnum]!.awayfirst)
        }
    }
    
    /*
     Incriments set one if necessary when the user presses the '+' button for a particular court
    */
    func updateSetOne(_ sb: inout Scores, _ matchnum: Int, _ home: Bool) -> String {
        if home {
            if (sb.singlesMatches[matchnum]!.setscomplete == 0) {
                //first set not complete
                sb.singlesMatches[matchnum]!.homefirst += 1
                if (sb.singlesMatches[matchnum]!.homefirst == 6 && sb.singlesMatches[matchnum]!.awayfirst < 5) {
                    sb.singlesMatches[matchnum]!.setscomplete += 1
                    sb.singlesMatches[matchnum]!.homesets += 1
                }
                if (sb.singlesMatches[matchnum]!.homefirst == 7) {
                    sb.singlesMatches[matchnum]!.setscomplete += 1
                    sb.singlesMatches[matchnum]!.homesets += 1
                }
            }
            return String(sb.singlesMatches[matchnum]!.homefirst)
        } else {
            if (sb.singlesMatches[matchnum]!.setscomplete == 0) {
                //first set not complete
                sb.singlesMatches[matchnum]!.awayfirst += 1
                if (sb.singlesMatches[matchnum]!.awayfirst == 6 && sb.singlesMatches[matchnum]!.homefirst < 5) {
                    sb.singlesMatches[matchnum]!.setscomplete += 1
                    sb.singlesMatches[matchnum]!.awaysets += 1
                }
                if (sb.singlesMatches[matchnum]!.awayfirst == 7) {
                    sb.singlesMatches[matchnum]!.setscomplete += 1
                    sb.singlesMatches[matchnum]!.awaysets += 1
                }
            }
            return String(sb.singlesMatches[matchnum]!.awayfirst)
        }
    }
    
    /*
     Incriments set two if necessary when the user presses the '+' button for a particular court
    */
    func updateSetTwo(_ sb: inout Scores, _ matchnum: Int, _ home: Bool) -> String {
        if home {
            if (sb.singlesMatches[matchnum]!.setscomplete == 1) {
                //second set not complete
                sb.singlesMatches[matchnum]!.homesecond += 1
                if (sb.singlesMatches[matchnum]!.homesecond == 6 && sb.singlesMatches[matchnum]!.awaysecond < 5) {
                    sb.singlesMatches[matchnum]!.setscomplete += 1
                    sb.singlesMatches[matchnum]!.homesets += 1
                }
                if (sb.singlesMatches[matchnum]!.homesecond == 7) {
                    sb.singlesMatches[matchnum]!.setscomplete += 1
                    sb.singlesMatches[matchnum]!.homesets += 1
                }
            }
            return String(sb.singlesMatches[matchnum]!.homesecond)
        } else {
            if (sb.singlesMatches[matchnum]!.setscomplete == 1) {
                //second set not complete
                sb.singlesMatches[matchnum]!.awaysecond += 1
                print(sb.singlesMatches[matchnum]!.awaysecond)
                if (sb.singlesMatches[matchnum]!.awaysecond == 6 && sb.singlesMatches[matchnum]!.homesecond < 5) {
                    sb.singlesMatches[matchnum]!.setscomplete += 1
                    sb.singlesMatches[matchnum]!.awaysets += 1
                }
                if (sb.singlesMatches[matchnum]!.awaysecond == 7) {
                    sb.singlesMatches[matchnum]!.setscomplete += 1
                    sb.singlesMatches[matchnum]!.awaysets += 1
                }
                //print(sb.singlesMatches[matchnum]!.setscomplete)
                print(sb.singlesMatches[matchnum]!.awaysets)
            }
            return String(sb.singlesMatches[matchnum]!.awaysecond)
        }
    }
    
    /*
     Decrements set two value on particular court if necessary.
    */
    func subSetTwo(_ sb: inout Scores, _ matchnum: Int, _ home: Bool) -> String {
        if home {
            if (sb.singlesMatches[matchnum]!.setscomplete == 1) {
                if (sb.singlesMatches[matchnum]!.awaysecond == 7 && sb.singlesMatches[matchnum]!.homesecond < 6) {
                    return String(sb.singlesMatches[matchnum]!.homesecond)
                }
                if (sb.singlesMatches[matchnum]!.homesecond == 0) {
                    if (sb.singlesMatches[matchnum]!.awaysecond == 0) {
                        sb.singlesMatches[matchnum]!.setscomplete -= 1
                    }
                    return String(0)
                }
                
                if setIsOver(&sb, matchnum, 2) {
                    if sb.singlesMatches[matchnum]!.homesecond == 7 {
                        sb.singlesMatches[matchnum]!.homesets -= 1
                        //sb.singlesMatches[matchnum]!.setscomplete -= 1
                    } else if sb.singlesMatches[matchnum]!.homesecond == 6 && sb.singlesMatches[matchnum]!.awaysecond != 7 {
                        sb.singlesMatches[matchnum]!.homesets -= 1
                        //sb.singlesMatches[matchnum]!.setscomplete -= 1
                    }
                }
                sb.singlesMatches[matchnum]!.homesecond -= 1
            }
            return String(sb.singlesMatches[matchnum]!.homesecond)
        } else {
            if (sb.singlesMatches[matchnum]!.setscomplete == 1) {
                if (sb.singlesMatches[matchnum]!.homesecond == 7 && sb.singlesMatches[matchnum]!.awaysecond < 6) {
                    return String(sb.singlesMatches[matchnum]!.awaysecond)
                }
                if (sb.singlesMatches[matchnum]!.awaysecond == 0) {
                    if sb.singlesMatches[matchnum]!.homesecond == 0 {
                        sb.singlesMatches[matchnum]!.setscomplete -= 1
                    }
                    return String(0)
                }
                sb.singlesMatches[matchnum]!.awaysecond -= 1
                
            }
            return String(sb.singlesMatches[matchnum]!.awaysecond)
        }
    }
    
    /*
     Incriments set two if necessary when the user presses the '+' button for a particular court
     */
    func updateSetThree(_ sb: inout Scores, _ matchnum: Int, _ home: Bool) -> String {
        if home {
            if (sb.singlesMatches[matchnum]!.setscomplete == 2) {
                if (!sb.singlesMatches[matchnum]!.matchcomplete) {
                    sb.singlesMatches[matchnum]!.homethird += 1
                    if (sb.singlesMatches[matchnum]!.homethird == 6 && sb.singlesMatches[matchnum]!.awaythird < 5) {
                        sb.singlesMatches[matchnum]!.setscomplete += 1
                        sb.singlesMatches[matchnum]!.homesets += 1
                    }
                    if (sb.singlesMatches[matchnum]!.homethird == 7) {
                        sb.singlesMatches[matchnum]!.setscomplete += 1
                        sb.singlesMatches[matchnum]!.homesets += 1
                    }
                }
            }
            return String(sb.singlesMatches[matchnum]!.homethird)
        } else {
            if (sb.singlesMatches[matchnum]!.setscomplete == 2) {
                if (!sb.singlesMatches[matchnum]!.matchcomplete) {
                    sb.singlesMatches[matchnum]!.awaythird += 1
                    if (sb.singlesMatches[matchnum]!.awaythird == 6 && sb.singlesMatches[matchnum]!.homethird < 5) {
                        sb.singlesMatches[matchnum]!.setscomplete += 1
                        sb.singlesMatches[matchnum]!.awaysets += 1
                    }
                    if (sb.singlesMatches[matchnum]!.awaythird == 7) {
                        sb.singlesMatches[matchnum]!.setscomplete += 1
                        sb.singlesMatches[matchnum]!.awaysets += 1
                    }
                }
            }
            return String(sb.singlesMatches[matchnum]!.awaythird)
        }
    }
    
    /*
     Returns string of decremented set three value on a given court, if necessary.
    */
    func subSetThree(_ sb: inout Scores, _ matchnum: Int, _ home: Bool) -> String {
        if home {
            if (sb.singlesMatches[matchnum]!.setscomplete == 2) {
                if (sb.singlesMatches[matchnum]!.awaythird == 7 && sb.singlesMatches[matchnum]!.homethird < 6) {
                    return String(sb.singlesMatches[matchnum]!.homethird)
                }
                if (sb.singlesMatches[matchnum]!.homethird == 0) {
                    if (sb.singlesMatches[matchnum]!.awaythird == 0) {
                        sb.singlesMatches[matchnum]!.setscomplete -= 1
                        
                    }
                    return String(0)
                }
                sb.singlesMatches[matchnum]!.homethird -= 1
                if setIsOver(&sb, matchnum, 3) {
                    sb.singlesMatches[matchnum]!.awaysets += 1
                    sb.singlesMatches[matchnum]!.setscomplete += 1
                    
                }
            }
            return String(sb.singlesMatches[matchnum]!.homethird)
        } else {
            if (sb.singlesMatches[matchnum]!.setscomplete == 2) {
                if (sb.singlesMatches[matchnum]!.homethird == 7 && sb.singlesMatches[matchnum]!.awaythird < 6) {
                    return String(sb.singlesMatches[matchnum]!.awaythird)
                }
                if (sb.singlesMatches[matchnum]!.awaythird == 0) {
                    if (sb.singlesMatches[matchnum]!.homethird == 0) {
                        //sb.singlesMatches[matchnum]!.setscomplete -= 1
                        
                    }
                    return String(0)
                }
                sb.singlesMatches[matchnum]!.awaythird -= 1
                if setIsOver(&sb, matchnum, 3) {
                    sb.singlesMatches[matchnum]!.homesets += 1
                    sb.singlesMatches[matchnum]!.setscomplete += 1
                }
            }
            return String(sb.singlesMatches[matchnum]!.awaythird)
        }
    }
    
    /*
     Remove a total point off the scoreboard if decrement leads to subtraction of total score
    */
    func subCompletedIfThird(_ sb: inout Scores, _ matchnum: Int, _ home: Bool) {
        if sb.singlesMatches[matchnum]!.setscomplete != 3 {
            return
        }
        
        if home {
            if (sb.singlesMatches[matchnum]!.homethird - sb.singlesMatches[matchnum]!.awaythird >= 2) {
                sb.singlesMatches[matchnum]!.homesets -= 1
                sb.singlesMatches[matchnum]!.setscomplete -= 1
                sb.hometotalcount -= 1
            }
        } else {
            if (sb.singlesMatches[matchnum]!.awaythird - sb.singlesMatches[matchnum]!.homethird >= 2) {
                sb.singlesMatches[matchnum]!.awaysets -= 1
                sb.singlesMatches[matchnum]!.setscomplete -= 1
                sb.awaytotalcount -= 1
            }
        }
    }
    
    /*
     Same principle as that above, except checking for a straight set victory going away.
    */
    func subCompletedIfSecond(_ sb: inout Scores, _ matchnum: Int, _ home: Bool) {
        if sb.singlesMatches[matchnum]!.setscomplete != 2 {
            return
        }
        if sb.singlesMatches[matchnum]!.awaythird + sb.singlesMatches[matchnum]!.homethird > 0 {
            return
        }
        if home {
            if sb.singlesMatches[matchnum]!.homesets == 2 && sb.singlesMatches[matchnum]!.homesecond - sb.singlesMatches[matchnum]!.awaysecond >= 2{
                sb.singlesMatches[matchnum]!.homesets -= 1
                sb.singlesMatches[matchnum]!.setscomplete -= 1
                sb.hometotalcount -= 1
            }
        } else {
            if (sb.singlesMatches[matchnum]!.awaysecond - sb.singlesMatches[matchnum]!.homesecond >= 2) && sb.singlesMatches[matchnum]!.awaysets == 2 {
                sb.singlesMatches[matchnum]!.awaysets -= 1
                sb.singlesMatches[matchnum]!.setscomplete -= 1
                sb.awaytotalcount -= 1
            }
        }
        
        if home {
            if (sb.singlesMatches[matchnum]!.homethird - sb.singlesMatches[matchnum]!.awaythird >= 2) {
                sb.singlesMatches[matchnum]!.homesets -= 1
                sb.singlesMatches[matchnum]!.setscomplete -= 1
                sb.hometotalcount -= 1
            }
        } else {
            if (sb.singlesMatches[matchnum]!.awaythird - sb.singlesMatches[matchnum]!.homethird >= 2) {
                sb.singlesMatches[matchnum]!.awaysets -= 1
                sb.singlesMatches[matchnum]!.setscomplete -= 1
                sb.awaytotalcount -= 1
            }
        }
    }
    
    
}
