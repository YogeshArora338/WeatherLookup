//
//  WeatherDetailController.swift
//  WeatherLookup
//
//  Created by Yogesh Arora on 11/03/22.
//

import UIKit

final class WeatherDetailController: BaseViewController {
    
    struct ItemData {
        public let temprature: Double
        public let feelsLike: Double
        public let name: String
        public let description: String
        
        // MARK: - Init
        public init(temprature: Double,
                    feelsLike: Double,
                    name: String,
                    description: String) {
            self.temprature = temprature
            self.feelsLike = feelsLike
            self.name = name
            self.description = description
        }
        
        var feelsLikeText: String {
            return "Feels Like: \(self.feelsLike)"
        }
    }
    
    // MARK: - UI Components
    @IBOutlet weak var lblTemprature: UILabel!
    @IBOutlet weak var lblFeelsLike: UILabel!
    @IBOutlet weak var lblWeatherName: UILabel!
    @IBOutlet weak var lblWeatherDescription: UILabel!
    
    public var itemData: ItemData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let itemData = self.itemData {
            self.lblTemprature.text = "\(itemData.temprature)"
            self.lblFeelsLike.text = itemData.feelsLikeText
            self.lblWeatherName.text = itemData.name
            self.lblWeatherDescription.text = itemData.description
        }
    }
}
