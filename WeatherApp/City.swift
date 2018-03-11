//
//  City.swift
//  WeatherApp
//
//  Created by Eric Groseclos on 2018-03-06.
//  Copyright © 2018 Eric Groseclos. All rights reserved.
//

import Foundation

class City: NSCoding {
    
    let keyFavorite: String = "favorite"
    let keyLatitude: String = "latitude"
    let keyLongitude: String = "longitude"
    let keyTemperature: String = "temperature"
    let keySpeed: String = "speed"
    let keyCity: String = "city"
    let keyCountry: String = "country"
    let keyWeather: String = "weather"
    
    var favorite: Bool
    
    var lat : Float
    var long : Float
    var temp : Float
    var speed : Float
    
    var city : String
    var country : String
    var weather : String
    
    // temp is reduced by 272.15 to convert it to Celsius
    init(lat: Float,long: Float,temp: Float,speed: Float,city: String,country: String,weather: String) {
        self.favorite = false
        
        self.lat = lat
        
        self.long = long
        
        self.temp = temp - 272.15
        
        self.speed = speed
        
        self.city = city
        
        self.country = country
        
        self.weather = weather
        
    }
    
    // Uses serialization to save to memory.
    func encode(with aCoder: NSCoder) {
        if self.favorite {
            aCoder.encode("true", forKey: keyFavorite)
        } else {
            aCoder.encode("false", forKey: keyFavorite)
        }
        aCoder.encode(self.lat, forKey: keyLatitude)
        aCoder.encode(self.long, forKey: keyLongitude)
        aCoder.encode(self.temp, forKey: keyTemperature)
        aCoder.encode(self.speed, forKey: keySpeed)
        aCoder.encode(self.city, forKey: keyCity)
        aCoder.encode(self.country, forKey: keyCountry)
        aCoder.encode(self.weather, forKey: keyWeather)
    }
    
    // Deserializes from memory.
    required init?(coder aDecoder: NSCoder) {
        
        if (aDecoder.decodeObject(forKey: keyFavorite) as! String) == "true" {
            self.favorite = true
        } else {
            self.favorite = false
        }
        
        self.lat = aDecoder.decodeObject(forKey: keyLatitude) as! Float
        self.long = aDecoder.decodeObject(forKey: keyLongitude) as! Float
        self.temp = aDecoder.decodeObject(forKey: keyTemperature) as! Float
        self.speed = aDecoder.decodeObject(forKey: keySpeed) as! Float
        
        self.city = aDecoder.decodeObject(forKey: keyCity) as! String
        self.country = aDecoder.decodeObject(forKey: keyCountry) as! String
        self.weather = aDecoder.decodeObject(forKey: keyWeather) as! String
    }

}
