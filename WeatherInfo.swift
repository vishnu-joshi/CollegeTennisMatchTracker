//
//  WeatherInfo.swift
//  CollegeTennisTracker
//
//  Created by Vishnu Joshi on 6/16/19.
//  Copyright © 2019 Vishnu Joshi. All rights reserved.
//

import Foundation

class WeatherInfo {
    let cityName : String;
    let temp : Double;
    
    init(city : String, temper : Double) {
        self.cityName = city;
        self.temp = temper;
    }
}
