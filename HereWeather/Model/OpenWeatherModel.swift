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
    
    private var weatherResponse: OpenWeatherResponse?
    
    func requestThreeHourAPI(lat: Double, lon: Double, 
                             callBack: @escaping (_ response: OpenWeatherResponse) -> (), errorCallBack: @escaping () -> ()) {
        APIClient.request(OpenWeatherResponse.self,
                          router: APIRouter.call3HourForecast(lat: lat, lon: lon),
                          success: {(response: OpenWeatherResponse) -> () in
                              print(#function, response)
                              callBack(response)
            
                          },
                          failure: {(error: AFError) -> () in
                              print(#function, error)
                              errorCallBack()
                          }
        )
    }
    
    func setResponse(response: OpenWeatherResponse) {
        if let weatherResponse {
            weatherResponse.cod = response.cod
            weatherResponse.message = response.message
            weatherResponse.cnt = response.cnt
            weatherResponse.list = response.list
            weatherResponse.city = response.city
        } else {
            weatherResponse = response
        }
    }
    
    func clearResponse() {
        
    }
    
}


