//
//  WeatherCompareViewController.swift
//  WeatherApp
//
//  Created by Eric Groseclos on 2018-03-27.
//  Copyright © 2018 Eric Groseclos. All rights reserved.
//

import UIKit

class WeatherCompareViewController: UIViewController {

    @IBOutlet weak var cityOne: UITextField!
    
    @IBOutlet weak var cityTwo: UITextField!
    
    @IBOutlet weak var compareButton: UIButton!
    
    private let error: String = "City not found"
    
    var model: Model!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Ensures that that user has written
    // names of cities that exist in the
    // app. The TextFields inform the user
    // if they don't exist.
    @IBAction func compare(_ sender: Any) {
        if model.cityExists(cityOne.text!) && model.cityExists(cityTwo.text!) {
            drawTable()
        } else {
            if  model.cityExists(cityOne.text!) == false {
                cityOne.text = self.error
            }
            
            if  model.cityExists(cityTwo.text!) == false {
                cityTwo.text = self.error
            }
        }
    }
    
    // Draws a staple diagram for the
    // temperature and wind speed of
    // the two cities.
    func drawTable() {
        let cityOne: City = model.getCity(self.cityOne.text!)!
        
        let cityTwo: City = model.getCity(self.cityTwo.text!)!
    }
    
}
