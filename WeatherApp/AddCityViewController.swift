//
//  AddCityViewController.swift
//  WeatherApp
//
//  Created by Eric Groseclos on 2018-03-18.
//  Copyright © 2018 Eric Groseclos. All rights reserved.
//

import UIKit

class AddCityViewController: UIViewController {
    
    var model: Model?
    
    private let placeholder: String = "Enter the name of a city"
    
    private let errorMessage: String = "Couldn't get weather info..."
    
    @IBOutlet weak var inputTextField: UITextField!
    
    @IBOutlet weak var fetechWeatherButton: UIButton!
    
    // Sets the background image.
    // Makes the TextField first responder,
    // for a better user experience.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_image")!)
        
        self.inputTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Ensures that the user has written
    // something. Also checks that the written
    // city doesn't already exists in the array.
    // Then, a http GET request is made to
    // the web API 'openweathermap'.
    // The app then performs a segue to a new
    // WeatherTableView.
    @IBAction func fetch(_ sender: Any) {
        
        let cityString: String = inputTextField.text!
        //print("cityString: \(cityString)")
        if cityString != placeholder && cityString != "" && (model?.cityExists(cityString))! == false {
            let success = model?.weatherForCity(cityString)
            
            if success! {
                self.performSegue(withIdentifier:"backToListSegue", sender: self)
            } else {
                inputTextField.text = errorMessage
            }
        }
    }
    
    // Ensures that the TableView has access to the
    // same Model instance as this class.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "backToListSegue" {
            let navController: UINavigationController = segue.destination as! UINavigationController
            
            let weatherList = navController.viewControllers.first as! WeatherTableViewController
            
            weatherList.model = model
        }
    }
    
}
