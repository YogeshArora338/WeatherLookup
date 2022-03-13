//
//  WeatherDataModel+Mapper.swift
//  WeatherLookup
//
//  Created by Yogesh Arora on 12/03/22.
//

extension WeatherDataModel {
    func mapToItemData(_ index: Int) -> WeatherDetailController.ItemData {
        let weather = self.weather[index]
        let itemData = WeatherDetailController.ItemData(temprature: self.main.temp,
                                         feelsLike: self.main.feelsLike,
                                         name: weather.main,
                                         description: weather.description)
        return itemData
    }
}
