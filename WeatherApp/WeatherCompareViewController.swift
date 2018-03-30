//
//  WeatherCompareViewController.swift
//  WeatherApp
//
//  Created by Eric Groseclos on 2018-03-27.
//  Copyright © 2018 Eric Groseclos. All rights reserved.
//

import UIKit
import GraphKit

class WeatherCompareViewController: UIViewController, GKBarGraphDataSource {
    
    @IBOutlet weak var cityOne: UITextField!
    
    @IBOutlet weak var cityTwo: UITextField!
    
    @IBOutlet weak var compareButton: UIButton!
    
    @IBOutlet weak var diagram: GKBarGraph!
    
    private let error: String = "City not found"
    
    private var data1: City!
    
    private var data2: City!
    
    var model: Model!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        diagram.dataSource = self
        diagram.marginBar = 30
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Ensures that the user has written
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
    
    // Draws a GKBarGraph for the
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
        
        self.diagram.draw()
    }
    
    // The number of bars are always four;
    // Two bars for the temperatures
    // Two bars for the wind speeds
    func numberOfBars() -> Int {
        return 4
    }
    
    // The values in the City objects, i.e. the
    // graph data, are scaled up to fit better
    // in the graph.
    func valueForBar(at index: Int) -> NSNumber! {
        
        switch index {
        case 0:
            return data1.temp * 2 as NSNumber
        case 1:
            return data2.temp * 2 as NSNumber
        case 2:
            return data1.speed * 4 as NSNumber
        case 3:
            return data2.speed * 4 as NSNumber
        default:
            return 0
        }
    }
    
    // Assigns the appropriate title,
    // depending on the index of the bar.
    func titleForBar(at index: Int) -> String! {
        
        switch index {
        case 0:
            return "Temp 1"
        case 1:
            return "Temp 2"
        case 2:
            return "Speed 1"
        case 3:
            return "Speed 2"
        default:
            return ""
        }
    }
    
    // Gives the temperature bars a distinct red color.
    // Also gives the wind speed bars a distinct blue color.
    func colorForBar(at index: Int) -> UIColor! {
        
        switch index {
        case 0:
            return UIColor.red
        case 1:
            return UIColor.red
        case 2:
            return UIColor.blue
        case 3:
            return UIColor.blue
        default:
            return UIColor.white
        }
    }
    
}
