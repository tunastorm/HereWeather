//
//  OpenWeatherModel.swift
//  HereWeather
//
//  Created by 유철원 on 6/19/24.
//

import Foundation
import Alamofire

class OpenWeatherModel {
    
    private init() {}
    
    static let model = OpenWeatherModel()
    
    private var response = ""
    
    func requestAPI(lat: Double, lon: Double) {
        APIClient.request(OpenWeatherResponse.self,
                          router: OpenWeatherRouter.call3HourForecast(lat: lat, lon: lon),
                          success: {(response: OpenWeatherResponse) -> () in
                              print(#function, response)
                          },
                          failure: {(error: AFError) -> () in
                              print(#function, error)
                          }
        )
    }
}


struct OpenWeatherResponse: Decodable {
    let cod: String
    let message: Int
    let cnt: Int
    let list: [ForeCast]
}

struct ForeCast: Decodable {
    let dt: Int
    let date: String
    let main: Main
    let wind: Wind
    
    enum CodingKeys: String, CodingKey {
        case dt
        case date = "dt_txt"
        case main
        case wind
    }
}

struct Main: Decodable {
    let temp: Double
    let humidity: Int
}

struct Wind: Decodable {
    let speed: Double
}
