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
    
    init(lat: Float,long: Float,temp: Float,city: String,country: String,weather: String) {
        self.lat = lat
        print(lat)
        self.long = long
        print(long)
        self.temp = temp - 272.15
        print(temp)
        self.city = city
        print(city)
        self.country = country
        print(country)
        self.weather = weather
        print(weather)
    }
    
}
