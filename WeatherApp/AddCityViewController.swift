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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.inputTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Ensures that the user has written
    // something, before making a http GET
    // request to the web API 'openweathermap'.
    // The app then performs a segue to a new
    // WeatherTableView.
    @IBAction func fetch(_ sender: Any) {
        if inputTextField.text != placeholder && inputTextField.text != "" {
            let success = model?.weatherForCity(inputTextField.text!)
            
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
