//
//  Model.swift
//  WeatherApp
//
//  Created by Eric Groseclos on 2018-03-06.
//  Copyright © 2018 Eric Groseclos. All rights reserved.
//

import Foundation

class Model: NSObject {
    
    func weatherForCity(_ city: String) {
        let weather = Weather()
        
        let weatherInfo = weather.retrieveWeather(city)
        
        if (weatherInfo != nil) {
            print("Temperature: " + (weatherInfo?.temp.description)!)
        } else {
            print("nil returned")
        }
    }
    
}
