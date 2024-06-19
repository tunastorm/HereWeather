//
//  OpenWeatherResponse.swift
//  HereWeather
//
//  Created by 유철원 on 6/19/24.
//

import Foundation


struct OpenWeatherResponse: Decodable {
    var cod: String
    var message: Int
    var cnt: Int
    var list: [ForeCast]
    var city: City
}

struct ForeCast: Decodable {
    var dt: Int
    var date: String
    var main: Main
    var wind: Wind
    
    enum CodingKeys: String, CodingKey {
        case dt
        case date = "dt_txt"
        case main
        case wind
    }
}

struct Main: Decodable {
    var temp: Double
    var humidity: Int
}

struct Wind: Decodable {
    var speed: Double
}

struct City: Decodable {
    var name: String
    var contry: String
}


