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
    
    // Loads the saved cities in memory into array cities.
    override init() {
        let preferences: UserDefaults = UserDefaults.standard
        
        let data: NSData? = preferences.object(forKey: citySaveKey) as? NSData
        
        if data != nil {
            self.cities = NSKeyedUnarchiver.unarchiveObject(with: data! as Data) as! [City]
        }
    }
    
    // Returns the amount of City objects in the array.
    func cityAmount() -> Int {
        print("Amount of cities in array: " + String(cities.count))
        return cities.count
    }
    
    // Adds the city to the end of the array of cities.
    // Saves the updated array.
    func addCity(_ city: City) {
        print("City " + city.cityName + " added!")
        cities.append(city)
        save()
    }
    
    // Returns the names of all cities in the array,
    // in lowercased letters.
    func getAllCityNames() -> [String] {
        var names: [String] = []
        
        for city: City in self.cities {
            names.append(city.cityName.lowercased())
        }
        
        return names
    }
    
    // Saves the list of cities via serialization.
    func save() {
        let preferences: UserDefaults = UserDefaults.standard
        
        var filteredCities = [City]()
        
        for city: City in self.cities {
            if city.favorite {
                filteredCities.append(city)
            }
        }
        
        let data: NSData = NSKeyedArchiver.archivedData(withRootObject: filteredCities) as NSData
        
        preferences.set(data, forKey:citySaveKey)
        
        preferences.synchronize
    }
  
    // Gets a City object for the tapped cell in the TableView.
    // The cells row number corresponds to the index in array cities.
    func getCity(_ cityToRetrieve: Int?) -> City? {
        
        if cityToRetrieve != nil && cities.isEmpty == false {
            //print("City " + cities[cityToRetrieve!].city + " retrieved!")
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
        
        if cities.isEmpty == false {
            let city: City = cities[cityToToggle!]
            
            let currentPriority: Bool = city.favorite
            
            if currentPriority {
                cities[cityToToggle!].favorite = false
            } else {
                cities[cityToToggle!].favorite = true
            }
            
            save()
        }
    }
    
    // Creates an instance of class Weather.
    // Retrieves a City object for the given city.
    // Adds it to the array of cities.
    func weatherForCity(_ city: String) {
        let weather = Weather()
        
        let weatherInfo = weather.retrieveWeather(city)
        
        if (weatherInfo != nil) {
            addCity(weatherInfo!)
        } else {
            print("nil returned")
            // Remove this this else statement at the end of the project!
        }
    }
}
