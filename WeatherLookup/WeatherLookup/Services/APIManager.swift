//
//  APIManager.swift
//  WeatherLookup
//
//  Created by Yogesh Arora on 11/03/22.
//

import Foundation

protocol APIManagerProtocol{
    func getWeather(cityName: String, completion: @escaping (WeatherDataModel?) -> Void)
}

struct APIManager: APIManagerProtocol {
    static let baseURL: String = "https://api.openweathermap.org/data/2.5/weather?units=metric"
    static let apiKey: String = "65d00499677e59496ca2f318eb68c049"
    
    func getWeather(cityName: String, completion: @escaping (WeatherDataModel?) -> Void) {
        let fullUrl = "\(APIManager.baseURL)&q=\(cityName)&appid=\(APIManager.apiKey)"
        guard let url = URL(string: fullUrl) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                completion(nil)
            }
            
            
            let decoded = self.decodeJSON(type: WeatherDataModel.self, from: data)
            completion(decoded)
        }
        .resume()
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T?{
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = from, let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
}


