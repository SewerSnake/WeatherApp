//
//  Model.swift
//  WeatherApp
//
//  Created by Eric Groseclos on 2018-03-06.
//  Copyright © 2018 Eric Groseclos. All rights reserved.
//

import Foundation

class Model: NSObject {
    
    var cities = [City]()
    
    func cityAmount() -> Int {
        return cities.count
    }
    
    func weatherForCity(_ city: String) {
        let weather = Weather()
        
        let weatherInfo = weather.retrieveWeather(city)
        
        if (weatherInfo != nil) {
            cities.append(weatherInfo!)
        } else {
            print("nil returned")
        }
    }
    
}
