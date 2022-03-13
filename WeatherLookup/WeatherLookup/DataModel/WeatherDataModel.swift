//
//  WeatherDataModel.swift
//  WeatherLookup
//
//  Created by Yogesh Arora on 12/03/22.
//

struct WeatherDataModel: Decodable {
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
    let feelsLike: Double
}

struct Weather: Decodable {
    let main: String
    let description: String
}
