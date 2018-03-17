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
    
    private var speed: AnyObject?
    
    private var cityName: AnyObject?
    
    private var country: AnyObject?
    
    private var weatherDescription: AnyObject?
    
    private var success: Bool?
    
    func retrieveWeather(_ cityToLoad: String) -> City? {
        
        let session = URLSession.shared
        
        if let safeString = cityToLoad.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            //print(safeString)
            let weatherRequestURL = NSURL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(safeString)&APPID=\(openWeatherMapAPIKey)")!
            
            let dataTask = session.dataTask(with: weatherRequestURL as URL) {
                (data: Data?, response: URLResponse?, error: Error?) in
                
                if let error = error {
                    print("Error:\n\(error)")
                    self.success = false
                } else {
                    
                    do {
                        
                        let weather = try JSONSerialization.jsonObject(
                            with: data!,
                            options: .mutableContainers) as! [String: AnyObject]
                        
                        if weather["cod"]!.isKind(of: NSNumber.self) {
                            
                            self.latitude = weather["coord"]!["lat"]!! as AnyObject
                            
                            self.longitude = weather["coord"]!["lon"]!! as AnyObject
                            
                            self.temperature = weather["main"]!["temp"]!! as AnyObject
                            
                            self.speed = weather["wind"]!["speed"]!! as AnyObject
                            
                            self.cityName = weather["name"]!
                            
                            self.country = weather["sys"]!["country"]!! as AnyObject
                            
                            var weatherObject = weather["weather"]![0] as! [String : AnyObject]
                            
                            self.weatherDescription = weatherObject["main"]!
                            
                            self.success = true
                        } else {
                            self.success = false
                        }
                        
                    } catch let jsonError as NSError {
                        
                        print("JSON error description: \(jsonError.description)")
                        
                        self.success = false
                    }
                }
            }
            
            dataTask.resume()
            
            repeat {} while (self.success == nil)
            
            if (self.success)! {
                
                let theCity = City(lat: latitude as! Float,long: longitude as! Float,temp: temperature as! Float,speed: speed as! Float,cityName: cityName as! String,country: country as! String,weather: weatherDescription as! String)
                
                return theCity
            }
        }
        return nil
    }
}
