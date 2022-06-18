//
//  WeatherData.swift
//  Weather_App
//
//  Created by Saif Alkhalaileh on 17/06/2022.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    
//    var temperatureString: String {
//        return String(format: "%.1f", main.temp)
//    }
//
//    var conditionName: String {
//        switch weather[0].id {
//            case 200...232:
//                return "cloud.bolt"
//            case 300...321:
//                return "cloud.drizzle"
//            case 500...531:
//                return "cloud.rain"
//            case 600...622:
//                return "cloud.snow"
//            case 701...781:
//                return "cloud.fog"
//            case 800:
//                return "sun.max"
//            case 801...804:
//                return "cloud"
//            default:
//                return "cloud"
//        }
//    }
//
//    var description: String {
//        return weather[0].description
//    }
    
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
}
