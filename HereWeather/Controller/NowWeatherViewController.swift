//
//  NowWeatherViewController.swift
//  HereWeather
//
//  Created by 유철원 on 6/19/24.
//

import UIKit

class NowWeatherViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        OpenWeatherModel.model.requestAPI(lat: 30, lon: 30)
        
    }
}
