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
        if inputTextField.text != self.placeholder && inputTextField.text != "" {
            model?.weatherForCity(inputTextField.text!)
        }
        
        self.performSegue(withIdentifier:"backToListSegue", sender: self)
    }
    
}
