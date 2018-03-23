//
//  WeatherTableViewController.swift
//  WeatherApp
//
//  Created by Eric Groseclos on 2018-03-08.
//  Copyright © 2018 Eric Groseclos. All rights reserved.
//

import UIKit

class WeatherTableViewController: UITableViewController, UISearchResultsUpdating {
   
    var model: Model?
    
    var searchResult : [String] = []
    
    var searchController: UISearchController!
    
    // If a Model instance hasn't been set via
    // an instance of class WeatherInfoController,
    // a new instance of the model class is created.
    // The search bar is also created.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if model == nil {
            self.model = Model()
        }
        
        createSearchBar()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Creates the search bar programmatically.
    func createSearchBar() {
        definesPresentationContext = true
        
        searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchResultsUpdater = self
        
        navigationItem.searchController = searchController
    }
    
    // Filters what is shown in the TableView.
    // Only cities that contain letters the user
    // has written in the search bar are shown.
    func updateSearchResults(for searchController: UISearchController) {
        
        if let text = searchController.searchBar.text?.lowercased() {
            
            searchResult = (model?.getAllCityNames().filter({ $0.contains(text) }))!
        } else {
            searchResult = []
        }
        
        tableView.reloadData()
    }
    
    // A Boolean variable to determine if
    // the search results should be considered or not.
    var shouldUseSearchResult : Bool {
        
        if let text = searchController.searchBar.text {
            
            return text.isEmpty ? false:searchController.isActive
            
        } else {
            return false
        }
    }
    

    // MARK: - Table view data source

    // Only one section is needed.
    override func numberOfSections(in tableView: UITableView) -> Int {
      
        return 1
    }

    // The number of rows is either equal to the amount of search
    // results, or the amount of cities in the array.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if shouldUseSearchResult {
            return searchResult.count
        } else {
            return model!.cityAmount()
        }
    }

    // The name and temperature of the city object
    // are loaded into the cell's labels.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "location", for: indexPath) as! WeatherCell
        
        let city: City?
        
        if shouldUseSearchResult {
            
            city = model?.getCity(searchResult[indexPath.row])
            
        } else {
            city = model!.getCity(indexPath.row)!
            cell.dataText = String(indexPath.row)
        }
        
        cell.cityName?.text = city?.cityName
        
        cell.temperature?.text = String(format:"%.2f", (city?.temp)!) + " °C"

        return cell
    }
    
    
    // MARK: - Navigation

    // Provides class WeatherInfoController with the
    // tapped cell's row number. As the content in the TableView
    // corresponds to the array in class Model, this means
    // that the correct City object is accessed.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "infoSegue" {
            
            let weatherInfo: WeatherInfoController  = segue.destination as! WeatherInfoController
            
            /*let pathForTappedCell: IndexPath = self.tableView.indexPathForSelectedRow!
            
            weatherInfo.cityIndexInMemory = pathForTappedCell.row*/
            let pathForTappedCell: IndexPath = self.tableView.indexPathForSelectedRow!
            
            let tappedCell: WeatherCell = self.tableView.cellForRow(at: pathForTappedCell) as! WeatherCell
            
            weatherInfo.cityIndexInMemory = Int(tappedCell.dataText!)
            
            weatherInfo.model = model
        }
        
        if segue.identifier == "fetchWeatherSegue" {
            let weatherFetcher: AddCityViewController = segue.destination as! AddCityViewController
            
            weatherFetcher.model = model
        }
    }
}
