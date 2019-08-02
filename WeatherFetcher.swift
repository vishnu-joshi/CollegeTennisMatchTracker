//
//  WeatherFetcher.swift
//  CollegeTennisTracker
//
//  Created by Vishnu Joshi on 6/15/19.
//  Copyright © 2019 Vishnu Joshi. All rights reserved.
//

import Foundation


protocol WeatherFetcherDelegate {
    func setWeather(weather: WeatherInfo);
}

class WeatherFetcher {
    
    var delegate : WeatherFetcherDelegate?
    
    //let weather = WeatherInfo(city: "Baltimore", temper: 70.0)
    func getWeather(_ city: String) {
        
        let cityWithFilling = city.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlHostAllowed)
        let APIkey = "510c2a1b4c115ca260424d526e931ce8"
        let path = "http://api.openweathermap.org/data/2.5/weather?q=" + cityWithFilling! + "&appid=" + APIkey;
        let url = URL(string: path);
        //A connection to the internet that essentially asks for the data
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { (data: Data?, response: URLResponse?, error: Error?) in
            do {
                let json = try JSON(data: data!)
                let temp = json["main"]["temp"].double
                let weatherdel = WeatherInfo(city: city, temper: temp!)
                if (self.delegate != nil) {
                    DispatchQueue.main.async {
                        self.delegate?.setWeather(weather: weatherdel)
                    }
                }
            } catch { }
        }
        task.resume();
        //print("City: \(weather.cityName)")

    }
}
