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
    
    // Returns the amount of City objects in the Array
    func cityAmount() -> Int {
        return cities.count
    }
  
    // Gets a City object for the tapped cell in the TableView.
    // The cells row number corresponds to the index in Array cities.
    func getCity(_ cityToRetrieve: Int?) -> City? {
        
        if cityToRetrieve != nil && cities.isEmpty == false {
            return cities[cityToRetrieve!]
        } else {
            return nil
        }
    }
    
    // Load the current value of 'favorite' from memory. This
    // is either true, to symbolize that its a user's favorite,
    // or false, i.e not a favorite.
    // The opposite value is then saved to memory.
    func toggleFavorite(_ cityToToggle: Int?) {
        //var city: City = cities[cityToToggle!]
        
    }
    
    // Creates an instance of class Weather.
    // Retrieves a City object for the given city.
    // Adds it to the Array of cities.
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
