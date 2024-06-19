//
//  APIKey.swift
//  MyCart
//
//  Created by 유철원 on 6/13/24.
//

import Foundation
import Alamofire


enum OpenWeatherAPI {
    
    static let baseURL = URL(string: "https://api.openweathermap.org/data/2.5/forecast")!
    
    static let token = ""
    
    enum MyAuth {
        static let APIKey = "894f31a8cbcecc9b333b66ec28e96d76"
    }
}
