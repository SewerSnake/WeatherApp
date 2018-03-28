//
//  Model.swift
//  WeatherApp
//
//  Created by Eric Groseclos on 2018-03-06.
//  Copyright © 2018 Eric Groseclos. All rights reserved.
//

import Foundation

class Model: NSObject {
    
    private let favoritesKey: String = "favorites"
    
    private var favorites = [String]()
    
    private var cities = [City]()
    
    // Loads the saved cities in memory into array favorites.
    override init() {
        let preferences: UserDefaults = UserDefaults.standard
        
        let data: [String]? = preferences.object(forKey: favoritesKey) as? [String]
        
        if data != nil {
            self.favorites = preferences.object(forKey: favoritesKey) as! [String]
            /*print("Favorites loaded:")
            for favorite: String in self.favorites {
                print(favorite)
            }*/
        }
    }
    
    // Adds the city to the end of the array of cities.
    func addCity(_ city: City) {
        //print("City " + city.cityName + " added!")
        self.cities.append(city)
    }
    
    // Gets a City object for the name of
    // the desired city. 
    func getCity(_ desiredCity: String) -> City? {
        for city: City in self.cities {
            if city.cityName.lowercased() == desiredCity {
                return city
            }
        }
        return nil
    }
    
    // Gets a City object for the tapped cell in the TableView.
    // The cells row number corresponds to the index in array cities.
    func getCity(_ cityToRetrieve: Int?) -> City? {
        
        if cityToRetrieve != nil && cities.isEmpty == false {
            //print("City " + cities[cityToRetrieve!].city + " retrieved!")
            return self.cities[cityToRetrieve!]
        } else {
            return nil
        }
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
    
    // Returns the amount of City objects in the array of cities.
    func cityAmount() -> Int {
        //print("Amount of cities in array: " + String(cities.count))
        return self.cities.count
    }
    
    // Returns the amount of favorites in the array of favorites.
    func favoritesInMemory() -> Int {
        return self.favorites.count
    }
    
    // Returns the amount of favorites, by checking all of the cities.
    func amountOfFavorites() -> Int {
        var amount: Int = 0
        
        for city: City in self.cities {
            if city.favorite {
                amount = amount + 1
            }
        }
        
        return amount
    }
    
    // Returns the name of a favorited city for the given index.
    func getFavorite(_ index: Int) -> String {
        return self.favorites[index]
    }
    
    // Saves the list of the user's favorites to UserDefaults.
    func save() {
        let preferences: UserDefaults = UserDefaults.standard
        preferences.removeObject(forKey: favoritesKey)
        var filteredCities = [String]()
        
        for city: City in self.cities {
            if city.favorite {
                filteredCities.append(city.cityName)
                //print("City: " + city.cityName + " appended to favorites")
            }
        }
        
        preferences.set(filteredCities, forKey:favoritesKey)
        
        /*print("Favorites saved:")
        for favorite: String in filteredCities {
            print(favorite)
        }*/
        
        preferences.synchronize
    }
  
    // Load the current value of 'favorite' from memory for
    // the corresponding city. This boolean value
    // is either true, to symbolize that it is a user's favorite,
    // or false, i.e. not a favorite.
    // The opposite value is then saved to memory.
    func toggleFavorite(_ cityToToggle: Int?) {
        
        if self.cities.isEmpty == false {
            let city: City = self.cities[cityToToggle!]
            
            let currentPriority: Bool = city.favorite
            
            if currentPriority {
                self.cities[cityToToggle!].favorite = false
                
            } else {
                self.cities[cityToToggle!].favorite = true
            }
            print(city.cityName + " set to " + String(self.cities[cityToToggle!].favorite))
            save()
        }
    }
    
    // Creates an instance of class Weather.
    // Retrieves a City object for the given city.
    // Adds it to the array of cities, if an error didn't
    // occur.
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
