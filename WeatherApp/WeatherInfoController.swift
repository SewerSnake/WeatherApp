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
    
    let title2 = "Remove from favorites"
    
    var model = Model()
    
    var city: City?
    
    var cityIndexInMemory: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if model.getCity(cityIndexInMemory!) != nil {
            city = model.getCity(cityIndexInMemory!)
        }
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // Loads an appropriate image,
    // depending on the weather.
    func loadImage() -> Void {
        print(self.city?.weather ?? "Couldn't find weather decription")
        
        switch self.city?.weather {
        case "sun"?:
            self.weatherImage.image = UIImage(named: "sunny")
        case "rain"?:
            self.weatherImage.image = UIImage(named: "rain")
        case "thunder"?:
            self.weatherImage.image = UIImage(named: "thunder")
        case "snow"?:
            self.weatherImage.image = UIImage(named: "snow")
        default:
            self.weatherImage.image = UIImage(named: "oops")
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
    }
    
}
