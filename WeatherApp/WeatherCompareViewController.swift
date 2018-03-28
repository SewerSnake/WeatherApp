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
    
    @IBOutlet weak var diagram: UIView!
    
    private let error: String = "City not found"
    
    private var data1: City!
    
    private var data2: City!
    
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
        let cityNameOne: String? = self.cityOne.text!
        let cityNameTwo: String? = self.cityTwo.text!
        
        if cityNameOne != nil {
            self.data1 = model.getCity(cityNameOne!.lowercased())!
        }
        
        if cityNameTwo != nil {
            self.data2 = model.getCity(cityNameTwo!.lowercased())!
        }
    }
    
}
