//
//  City.swift
//  WeatherApp
//
//  Created by Eric Groseclos on 2018-03-06.
//  Copyright © 2018 Eric Groseclos. All rights reserved.
//

import Foundation

class City {
    
    var favorite: Bool
    
    var lat: Float
    var long: Float
    var temp: Float
    var speed: Float
    
    var cityName: String
    var country: String
    var weather: String
    
    // temp is reduced by 272.15 to convert it to Celsius.
    // The web API returns a Kelvin value.
    init(_ lat: Float,_ long: Float,_ temp: Float,_ speed: Float,_ cityName: String,_ country: String,_ weather: String) {
        self.favorite = false
        
        self.lat = lat
        
        self.long = long
        
        self.temp = temp - 272.15
        
        self.speed = speed
        
        self.cityName = cityName
        
        self.country = country
        
        self.weather = weather
    }
}
