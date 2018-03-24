//
//  Model.swift
//  WeatherApp
//
//  Created by Eric Groseclos on 2018-03-06.
//  Copyright © 2018 Eric Groseclos. All rights reserved.
//

import Foundation

class Model: NSObject {
    
    let favoritesKey: String = "favorites"
    
    private var favorites = [String]()
    
    private var cities = [City]()
    
    // Loads the saved cities in memory into array favorites.
    override init() {
        let preferences: UserDefaults = UserDefaults.standard
        
        let data: [String]? = preferences.object(forKey: favoritesKey) as? [String]
        
        if data != nil {
            self.favorites = preferences.object(forKey: favoritesKey) as! [String]
        }
    }
    
    // Returns the amount of City objects in the array of cities.
    func cityAmount() -> Int {
        //print("Amount of cities in array: " + String(cities.count))
        return cities.count
    }
    
    // Returns the amount of favorites in the array of favorites.
    func amountOfFavorites() -> Int {
        return favorites.count
    }
    
    // Returns the name of a favorited city for the given index.
    func getFavorite(_ index: Int) -> String {
        return favorites[index]
    }
    
    // Adds the city to the end of the array of cities.
    func addCity(_ city: City) {
        //print("City " + city.cityName + " added!")
        cities.append(city)
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
    
    // Checks if the city the user wants to
    // add already exists in the array.
    // Returns true if it does.
    // Returns false if it doesn't.
    func cityExists(_ desiredCity: String) -> Bool {
        for city: City in self.cities {
            if city.cityName == desiredCity {
                return true
            }
        }
        return false
    }
    
    // Gets a City object for the name of
    // the desired city. Used when the search
    // bar is used.
    func getCity(_ desiredCity: String) -> City? {
        for city: City in self.cities {
            if city.cityName.lowercased() == desiredCity {
                return city
            }
        }
        return nil
    }
    
    // Saves the list of the users favorites to UserDefaults.
    func save() {
        let preferences: UserDefaults = UserDefaults.standard
        
        var filteredCities = [String]()
        
        for city: City in self.cities {
            if city.favorite {
                filteredCities.append(city.cityName)
            }
        }
        
        preferences.set(filteredCities, forKey:favoritesKey)
        
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
    // or false, i.e. not a favorite.
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
    // Adds it to the array of cities, if it could
    // be found. Otherwise, false is returned.
    func weatherForCity(_ city: String) -> Bool {
        let weather = Weather()
        
        let weatherInfo = weather.retrieveWeather(city)
        
        if (weatherInfo != nil) {
            addCity(weatherInfo!)
            return true
        } else {
            return false
        }
    }
}
