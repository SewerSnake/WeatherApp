//
//  ViewController.swift
//  WeatherApp
//
//  Created by Eric Groseclos on 2018-03-03.
//  Copyright © 2018 Eric Groseclos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var model = Model()
    //var city = [City]()

    override func viewDidLoad() {
        super.viewDidLoad()
        model.weatherForCity("Gothenburg")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}

