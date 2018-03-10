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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
      
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return model.cityAmount()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "location", for: indexPath) as! WeatherCell

        cell.cityName?.text = "Göteborg"
        cell.temperature?.text = "2 grader"

        return cell
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "infoSegue" {
            print("Cell tapped!")
            
            var weatherInfo: WeatherInfoController  = segue.destination as! WeatherInfoController
            
            let pathForTappedCell: IndexPath = self.tableView.indexPathForSelectedRow!
            
            weatherInfo.cityToRetrieve = pathForTappedCell.row
        }
    }
}
