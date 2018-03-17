//
//  WeatherInfoController.swift
//  WeatherApp
//
//  Created by Eric Groseclos on 2018-03-09.
//  Copyright © 2018 Eric Groseclos. All rights reserved.
//

import UIKit

class WeatherInfoController: UIViewController {
    
    @IBOutlet weak var cityName: UILabel!
    
    @IBOutlet weak var country: UILabel!
    
    @IBOutlet weak var weather: UILabel!
    
    @IBOutlet weak var temperature: UILabel!
    
    @IBOutlet weak var latitude: UILabel!
    
    @IBOutlet weak var longitude: UILabel!
    
    @IBOutlet weak var recommendation: UILabel!
    
    @IBOutlet weak var windSpeed: UILabel!
    
    @IBOutlet weak var weatherImage: UIImageView!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    let title1 = "Set as favorite"
    
    let title2 = "Remove favorite"
    
    var model: Model?
    
    var city: City?
    
    var cityIndexInMemory: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        city = model?.getCity(cityIndexInMemory!)
        
        loadImage()
        
        loadInfo()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Loads an appropriate image,
    // depending on the weather.
    func loadImage() {
        let desc: String? = self.city?.weather
        if desc != nil {
            print(desc!)
        }
        
        switch self.city?.weather {
        case "sunny"?:
            self.weatherImage.image = UIImage(named: "sunny")
        case "Clear"?:
            self.weatherImage.image = UIImage(named: "clear")
        case "Clouds"?:
            self.weatherImage.image = UIImage(named: "clouds")
        case "rain"?:
            self.weatherImage.image = UIImage(named: "rain")
        case "thunder"?:
            self.weatherImage.image = UIImage(named: "thunder")
        case "Snow"?:
            self.weatherImage.image = UIImage(named: "snow")
        default:
            self.weatherImage.image = UIImage(named: "oops")
        }
    }
    
    // Loads all information regarding
    // the weather into the approriate
    // graphical components.
    func loadInfo() {
        self.cityName.text = self.city?.cityName
        self.country.text = self.city?.country
        self.weather.text = self.city?.weather
        self.recommendation.text = recommend()
        
        self.temperature.text = String(self.city!.temp) + " °C"
        self.latitude.text = "lat: " + String(self.city!.lat)
        self.longitude.text = "long: " + String(self.city!.long)
        self.windSpeed.text = String(self.city!.speed) + " m/s"
    }
    
    // Gives different recommendations,
    // depending on the weather
    func recommend() -> String {
        if Double((city?.temp)!) <= 0.0 {
            return "Dress warmly!"
        } else if Double((city?.temp)!) >= 20.0 {
            return "Dress lightly!"
        } else {
            return ""
        }
    }
    
    // Changes the title of the button.
    // Saves the new state to memory via
    // the Model class.
    @IBAction func favorite(_ sender: Any) {
        
        if favoriteButton.currentTitle == title1 {
            favoriteButton.setTitle(title2, for: .normal)
        } else {
            favoriteButton.setTitle(title1, for: .normal)
        }
        
        model?.toggleFavorite(self.cityIndexInMemory!)
    }
    
}
