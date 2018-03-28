//
//  WeatherTableViewController.swift
//  WeatherApp
//
//  Created by Eric Groseclos on 2018-03-08.
//  Copyright © 2018 Eric Groseclos. All rights reserved.
//

import UIKit

class WeatherTableViewController: UITableViewController, UISearchResultsUpdating {
    
    private var shouldFetchWeather: Bool = false
    
    private var searchResult: [String] = []
    
    private var searchController: UISearchController!
    
    var model: Model?
    
    // The search bar is created for the TableView.
    // If a Model instance hasn't been set via
    // an instance of class WeatherInfoController,
    // a new instance of the model class is created.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createSearchBar()
        
        if model == nil {
            self.model = Model()
            
            shouldFetchWeather = true
        }
    }
    
    // For each city that is among the user's favorites,
    // a request is made to get the latest weather info
    // for those cities.
    // Still doesn't update the TableView...
    override func viewDidAppear(_ animated: Bool) {
        if shouldFetchWeather {
            getFavorites()
            showToast("Activate search bar!")
            shouldFetchWeather = false
        }
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
    
    // Retrieves all of the user's favorite cities
    // from the openweathermap API. A delay is used
    // between each http GET, to avoid overloading
    // the API.
    // Ensures that the user cannot interact with
    // the app during this time.
    func getFavorites() {
        let amountToLoad: Int = (self.model?.favoritesInMemory())!
        
        self.view.isUserInteractionEnabled = false
        
        for index in 0..<amountToLoad {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                
                let success = self.model?.weatherForCity((self.model?.getFavorite(index))!)
                
                if success! {
                    self.model?.toggleFavorite(index)
                }
            }
        }
        //tableView.reloadData()
        self.view.isUserInteractionEnabled = true
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
    var shouldUseSearchResult: Bool {
       
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
            
            let pathForTappedCell: IndexPath = self.tableView.indexPathForSelectedRow!
            
            let tappedCell: WeatherCell = self.tableView.cellForRow(at: pathForTappedCell) as! WeatherCell
            
            weatherInfo.cityIndexInMemory = Int(tappedCell.dataText!)
            
            weatherInfo.model = self.model
        }
        
        if segue.identifier == "fetchWeatherSegue" {
            let weatherFetcher: AddCityViewController = segue.destination as! AddCityViewController
            
            weatherFetcher.model = self.model
        }
        
        if segue.identifier == "compareWeatherSegue" {
            let weatherFetcher: WeatherCompareViewController = segue.destination as! WeatherCompareViewController
            
            weatherFetcher.model = model
        }
    }
    
    // Shows a message to the user,
    // equivalent to Android's toast message.
    func showToast(_ message: String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height - 100, width: 170, height: 35))
        
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        toastLabel.textColor = UIColor.white
        
        toastLabel.textAlignment = .center;
        
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        
        toastLabel.text = message
        
        toastLabel.alpha = 1.0
        
        toastLabel.layer.cornerRadius = 10
        
        toastLabel.clipsToBounds  =  true
        
        self.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
