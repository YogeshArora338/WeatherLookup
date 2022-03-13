//
//  BaseViewController.swift
//  WeatherLookup
//
//  Created by Yogesh Arora on 13/03/22.
//

import UIKit

class BaseViewController: UIViewController {
    
    enum DestinationType {
        case listing(cityName: String), detail(itemData: WeatherDetailController.ItemData, cityName: String)
    }
    
    public var cityName: String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.topItem?.title = self.cityName
    }
    
    func routeTo(_ destinationType: DestinationType) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        switch destinationType {
        case .listing(let cityName):
            let listingController = storyBoard.instantiateViewController(withIdentifier: "ListingController") as! WeatherListingController
            listingController.cityName = cityName
            self.navigationController?.pushViewController(listingController, animated: true)
        case .detail(let itemData, let cityName):
            let detailController = storyBoard.instantiateViewController(withIdentifier: "WeatherDetail") as! WeatherDetailController
            detailController.itemData = itemData
            detailController.cityName = cityName
            self.navigationController?.pushViewController(detailController, animated: true)
        }
    }
}
