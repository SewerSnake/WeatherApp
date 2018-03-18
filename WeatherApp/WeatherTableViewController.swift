//
//  WeatherTableViewController.swift
//  WeatherApp
//
//  Created by Eric Groseclos on 2018-03-08.
//  Copyright © 2018 Eric Groseclos. All rights reserved.
//

import UIKit

class WeatherTableViewController: UITableViewController, UISearchResultsUpdating {
   
    var model = Model()
    
    var searchResult : [String] = []
    
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSearchBar()
    }
    
    /*override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }*/
    
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
            
            searchResult = model.getAllCityNames().filter({ $0.contains(text) })
        } else {
            searchResult = []
        }
        
        tableView.reloadData()
    }
    
    // A Boolean variable to determine if
    // the search results should be considered or not.
    var shouldUseSearchResult : Bool {
        
        if let text = searchController.searchBar.text {
            
            if text.isEmpty {
                return false
            } else {
                return searchController.isActive
            }
        } else {
            return false
        }
        
    }

    // MARK: - Table view data source

    // Only one section is needed.
    override func numberOfSections(in tableView: UITableView) -> Int {
      
        return 1
    }

    // The number of rows is either equal to the amount of cities in
    // the array, or the search result number.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if shouldUseSearchResult {
            return searchResult.count
        } else {
            return model.cityAmount()
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "location", for: indexPath) as! WeatherCell
        
        let city: City = model.getCity(indexPath.row)!
        
        cell.cityName?.text = city.cityName
        
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
            
            let weatherInfo: WeatherInfoController  = segue.destination as! WeatherInfoController
            
            let pathForTappedCell: IndexPath = self.tableView.indexPathForSelectedRow!
            
            weatherInfo.cityIndexInMemory = pathForTappedCell.row
            
            weatherInfo.model = model
        }
        
        if segue.identifier == "fetchWeatherSegue" {
            let weatherFetcher: AddCityViewController = segue.destination as! AddCityViewController
            
            weatherFetcher.model = model
        }
    }
}
