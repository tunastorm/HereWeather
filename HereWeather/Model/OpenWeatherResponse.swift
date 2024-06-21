//
//  OpenWeatherResponse.swift
//  HereWeather
//
//  Created by 유철원 on 6/19/24.
//

import Foundation


struct OpenWeatherResponse: Decodable {
    var cnt: Int
    var list: [ForeCast]
    var city: City
}

struct City: Decodable {
    var name: String
    var country: String
}


struct ForeCast: Decodable {
    var date: String
    var main: Main
    var wind: Wind
    
    enum CodingKeys: String, CodingKey {
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




