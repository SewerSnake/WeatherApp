//
//  Weather.swift
//  WeatherApp
//
//  Created by Eric Groseclos on 2018-03-06.
//  Copyright © 2018 Eric Groseclos. All rights reserved.
//

import Foundation

class Weather {
    
    private let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/weather"
    
    private let openWeatherMapAPIKey = "a469edc58b1a58d9be6f1395fba10e34"
    
    private var latitude: AnyObject?
    
    private var longitude: AnyObject?
    
    private var temperature: AnyObject?
    
    private var cityName: AnyObject?
    
    private var country: AnyObject?
    
    private var weatherDescription: AnyObject?
    
    private var success: Bool?
    
    func retrieveWeather(_ cityToLoad: String) -> City? {
        
        self.success = false
        
        let session = URLSession.shared
        
        let weatherRequestURL = NSURL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityToLoad)&APPID=\(openWeatherMapAPIKey)")!
        
        // The data task retrieves the data via the URL.
        let dataTask = session.dataTask(with: weatherRequestURL as URL) {
            (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                print("Error:\n\(error)")
                self.success = false
            } else {
                
                do {
                    // Try to convert that data into a Swift dictionary
                    let weather = try JSONSerialization.jsonObject(
                        with: data!,
                        options: .mutableContainers) as! [String: AnyObject]
                    
                    // If we made it to this point, we've successfully converted the
                    // JSON-formatted weather data into a Swift dictionary.
                    // Let's print its contents to the debug console.
                    self.latitude = weather["coord"]!["lat"]!! as AnyObject
                    print("Latitude: \(String(describing: self.latitude))")
                    
                    self.longitude = weather["coord"]!["lon"]!! as AnyObject
                    print("Longitude: \(String(describing: self.longitude))")
                    
                    self.temperature = weather["main"]!["temp"]!! as AnyObject
                    print("Temperature: \(String(describing: self.temperature))")
                    
                    self.cityName = weather["name"]!
                    print("City: \(String(describing: self.cityName))")
                    
                    self.country = weather["sys"]!["country"]!! as AnyObject
                    print("Country: \(String(describing: self.country))")
                    
                    var weatherObject = weather["weather"]![0] as! [String : AnyObject]
                    
                    self.weatherDescription = weatherObject["main"]!
                    
                    print("Weather ID: \(String(describing: self.weatherDescription))")
                    
                    self.success = true
                    print("success set to true!")
                    
                } catch let jsonError as NSError {
                    
                    print("JSON error description: \(jsonError.description)")
                    
                    self.success = false
                }
            }
        }
        
        dataTask.resume()
        
        if (self.success)! {
            print("Entered!")
            let theCity = City(lat: latitude as! Float,long: longitude as! Float,temp: temperature as! Float,city: cityName as! String,country: country as! String,weather: weatherDescription as! String)
            
            return theCity
        } else {
            return nil
        }
    }
}
