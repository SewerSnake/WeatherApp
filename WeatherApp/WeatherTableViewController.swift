//
//  WeatherTableViewController.swift
//  WeatherApp
//
//  Created by Eric Groseclos on 2018-03-08.
//  Copyright © 2018 Eric Groseclos. All rights reserved.
//

import UIKit

class WeatherTableViewController: UITableViewController {
    
    var model = Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.weatherForCity("Berlin")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    // Only one section is needed.
    override func numberOfSections(in tableView: UITableView) -> Int {
      
        return 1
    }

    // The number of rows is equal to the amount of cities.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return 3
        return model.cityAmount()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "location", for: indexPath) as! WeatherCell
        
        let city: City = model.getCity(indexPath.row)!
        
        cell.cityName?.text = city.city
        
        cell.temperature?.text = String(city.temp) + " °C"

        return cell
    }
    
    
    // MARK: - Navigation

    // Provides class WeatherInfoController with the
    // tapped cell's row number. As the content in the TableView
    // corresponds to the Array in class Model, this means
    // that the correct City object is accessed.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "infoSegue" {
            
            var weatherInfo: WeatherInfoController  = segue.destination as! WeatherInfoController
            
            let pathForTappedCell: IndexPath = self.tableView.indexPathForSelectedRow!
            
            weatherInfo.cityIndexInMemory = pathForTappedCell.row
            
            weatherInfo.model = model
        }
    }
}
