//
//  APIRouter.swift
//  MyCart
//
//  Created by 유철원 on 6/13/24.
//

import Foundation
import Alamofire


enum APIRouter: URLRequestConvertible {
    
    case call3HourForecast(lat: Double, lon: Double)
    case geocoding(city: String, contry: String)
    
    func asURLRequest() throws -> URLRequest {
        let url = OpenWeatherAPI.baseURL
        var urlRequest = URLRequest(url: url)
        
        urlRequest.method = method
        
        if let parameters = parameters {
            return try encoding.encode(urlRequest, with: parameters)
        }
        
        return urlRequest
    }
    
    var method: HTTPMethod {
        switch self {
        case .call3HourForecast(let lat, let lon):
            return .get
        case .geocoding(let city, let contry):
            return .get
        }
    }
    
    static var defaultParameters: Parameters = [
        "appid" : OpenWeatherAPI.MyAuth.APIKey,
        "lang"  : "kr"
    ]
    
    private var parameters: Parameters? {
        switch self {
        case .call3HourForecast(let lat, let lon):
            APIRouter.defaultParameters["lat"] = lat
            APIRouter.defaultParameters["lon"] = lon
            return  APIRouter.defaultParameters
        case .geocoding(city: let city, contry: let country):
            APIRouter.defaultParameters["q"] = "\(city),\(country)"
            return APIRouter.defaultParameters
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .call3HourForecast(let lat, let lon):
            return URLEncoding.default
        case .geocoding(let city, let contry):
            return URLEncoding.default
        }
    }
}
