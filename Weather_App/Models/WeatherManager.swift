//
//  WeatherManager.swift
//  Weather_App
//
//  Created by Saif Alkhalaileh on 17/06/2022.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=49343bb4507611d60bf9b7cec4164f42&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil { //if let error = error
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            })
            task.resume()
        }
        
//        if let url = URL(string: urlString) {
//            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//                if let error = error {
//                    //print("Error with fetching weather: \(error)")
//                    self.delegate?.didFailWithError(error: error)
//                    return
//                }
//                if let safeData = data {
//                    if let weather = self.parseJSON(safeData) {
//                        //print("Successfully fetched weather: \(weather)")
//                        self.delegate?.didUpdateWeather(self, weather: weather)
//                    }
//                }
//            }
//            task.resume()
//        }

    }
    
    func parseJSON(_ data: Data) -> WeatherModel? { //WeatherData?
        //let decoder = JSONDecoder()
        do {
            let decodedData = try JSONDecoder().decode(WeatherData.self, from: data)
            let id = decodedData.weather[0].id
            let main = decodedData.weather[0].main
            let description = decodedData.weather[0].description
            let temp = decodedData.main.temp
            let name = decodedData.name

            let weather = WeatherModel(conditionId: id, main: main, description: description, temperature: temp, cityName: name)
            return weather
            
//            let name = decodedData.name
//            let main = decodedData.main
//            let weather = decodedData.weather
//
//            let weatherData = WeatherData(name: name, main: main, weather: weather)
//            return weatherData

        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
    
}
