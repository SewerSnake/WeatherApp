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
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // Loads an appropriate image,
    // depending on the weather.
    func loadImage() -> Void {
        /*switch  {
        case <#pattern#>:
            <#code#>
        default:
            self.weatherImage.image = UIImage(named: "oops")
        }*/
    }
    
    @IBAction func favorite(_ sender: Any) {
        
        if favoriteButton.currentTitle == title1 {
            favoriteButton.setTitle(title2, for: .normal)
        } else {
            favoriteButton.setTitle(title1, for: .normal)
        }
    }
    
}
