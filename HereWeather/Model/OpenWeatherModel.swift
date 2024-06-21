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
                             callBack: @escaping (_ response: OpenWeatherResponse) -> (), 
                             errorCallBack: @escaping () -> ()) {
        APIClient.request(OpenWeatherResponse.self,
                          router: APIRouter.call3HourForecast(lat: lat, lon: lon),
                          success: {(response: OpenWeatherResponse) -> () in
                              self.setResponse(response: response)
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
            self.weatherResponse?.cnt = response.cnt
            self.weatherResponse?.list = pickNowWeather(responseList: response.list)
            self.weatherResponse?.city = response.city
        } else {
            var newResponse = response
            var newList = pickNowWeather(responseList: response.list)
            newResponse.list = newList
            weatherResponse = newResponse
        }
    }
    
    func clearResponse() {
        weatherResponse = nil
    }
    
    func pickNowWeather(responseList: [ForeCast]) -> [ForeCast]{
        let date = Date()
        print(#function, date)
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: Locale.current.identifier)
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
        var result: [ForeCast] = []
        for (idx, foreCast) in responseList.enumerated() {
            let nextIdx = idx + 1
            guard let nowDate = dateFormatter.date(from: foreCast.date) else {return []}
            if idx <= responseList.count - 2 {
                guard let nextDate = dateFormatter.date(from: responseList[nextIdx].date) else {return []}
                if nowDate <= date && date < nextDate {
                    result = [foreCast]
                    dateFormatter.dateFormat = "MM월 dd일 HH시 MM분"
                    result[0].date = dateFormatter.string(from: date)
                    break
                }
            } else if nowDate == date {
                result = [foreCast]
            }
        }
        return result
    }
    
    func getResponse() -> OpenWeatherResponse? {
        guard let weatherResponse else {
            return nil
        }
        return weatherResponse
    }
}


