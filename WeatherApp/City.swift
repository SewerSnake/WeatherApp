//
//  City.swift
//  WeatherApp
//
//  Created by Eric Groseclos on 2018-03-06.
//  Copyright © 2018 Eric Groseclos. All rights reserved.
//

import Foundation

class City {
    
    var lat : Float
    var long : Float
    var temp : Float
    
    var city : String
    var country : String
    var weather : String
    
    // temp is reduced by 272.15 to convert it to Celsius
    init(lat: Float,long: Float,temp: Float,city: String,country: String,weather: String) {
        self.lat = lat
        
        self.long = long
        
        self.temp = temp - 272.15
        
        self.city = city
        
        self.country = country
        
        self.weather = weather
        
    }
    
}
