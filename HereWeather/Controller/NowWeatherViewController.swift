//
//  NowWeatherViewController.swift
//  HereWeather
//
//  Created by 유철원 on 6/19/24.
//

import UIKit
import CoreLocation

import SnapKit
import Then


protocol chatRoomDelegate {
    func checkDeviceLocationAuthorization()
}



class NowWeatherViewController: UIViewController, chatRoomDelegate {
  
    let model = OpenWeatherModel.model
    
    let locationManager = CLLocationManager()
    
    var authorizationStatus: CLAuthorizationStatus?
    
    let chatRoomView = ChatRoomView()
    
   
    override func loadView() {
        self.view = chatRoomView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocationManager()
        setTableViewController()
        addUserAction()
        checkDeviceLocationAuthorization()
    }
    
    func addUserAction() {
        self.chatRoomView.delegate = self
    }
    
    func setLocationManager() {
        locationManager.delegate = self
    }
    
    func setTableViewController() {
        self.chatRoomView.tableView.delegate = self
        self.chatRoomView.tableView.dataSource = self
        self.chatRoomView.tableView.register(WeatherTableViewCell.self,
                           forCellReuseIdentifier: WeatherTableViewCell.identifier)
    }
    
    func requestOpenWeatherAPI(lat: CLLocationDegrees, lon: CLLocationDegrees) {
        model.clearResponse()
        OpenWeatherModel.model.requestThreeHourAPI(lat: lat, lon: lon,
        callBack: {(response: OpenWeatherResponse) -> () in
            self.chatRoomView.hereWeather = self.model.getResponse()
        },errorCallBack: {
            
        })
    }
}
