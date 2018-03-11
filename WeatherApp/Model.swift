//
//  Model.swift
//  WeatherApp
//
//  Created by Eric Groseclos on 2018-03-06.
//  Copyright © 2018 Eric Groseclos. All rights reserved.
//

import Foundation

class Model: NSObject {
    
    let citySaveKey: String = "cities"
    
    var cities = [City]()
    
    // Returns the amount of City objects in the Array
    func cityAmount() -> Int {
        return cities.count
    }
    
    // Adds the city to the end of the Array of cities.
    // Saves the updated Array.
    func addCity(_ city: City) {
        cities.append(city)
        save()
    }
    
    // Saves the list of cities via serialization.
    func save() {
        let preferences: UserDefaults = UserDefaults.standard;
        
        let data: NSData = NSKeyedArchiver.archivedData(withRootObject: self.cities) as NSData
        
        preferences.set(data, forKey:citySaveKey)
        
        preferences.synchronize;
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
    
    // Load the current value of 'favorite' from memory for
    // the corresponding city. This boolean value
    // is either true, to symbolize that its a user's favorite,
    // or false, i.e not a favorite.
    // The opposite value is then saved to memory.
    func toggleFavorite(_ cityToToggle: Int?) {
        let city: City = cities[cityToToggle!]
        
        let currentPriority: Bool = city.favorite
        
        if currentPriority {
            cities[cityToToggle!].favorite = false
        } else {
            cities[cityToToggle!].favorite = true
        }
        
        save()
    }
    
    // Creates an instance of class Weather.
    // Retrieves a City object for the given city.
    // Adds it to the Array of cities.
    func weatherForCity(_ city: String) {
        let weather = Weather()
        
        let weatherInfo = weather.retrieveWeather(city)
        
        if (weatherInfo != nil) {
            addCity(weatherInfo!)
        } else {
            print("nil returned")
        }
    }
}
