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
        super.loadView()
        self.view = chatRoomView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocationManager()
        setTableViewController()
        checkDeviceLocationAuthorization()
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

extension NowWeatherViewController {
    
    func showLocationSettingAlert() {
        let alert = UIAlertController(title: "위치 정보 이용",
                                      message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정 > 개인정보 보호'에서 위치서비스를 켜주세요",
                                      preferredStyle: .alert)
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            if let setting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(setting)
            }
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(goSetting)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    func checkDeviceLocationAuthorization() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                var status: CLAuthorizationStatus
    
                if #available(iOS 14.0, *) {
                    status = self.locationManager.authorizationStatus
                } else {
                    status = CLLocationManager.authorizationStatus()
                }
                
                print(#function, status.rawValue)
                DispatchQueue.main.async {
                    self.checkCurrentLocationAuthorization(status: status)
                }
            }
        }
    }
    
    func checkCurrentLocationAuthorization(status: CLAuthorizationStatus) {
        print(#function, status.rawValue)
        authIconToggle(status: status)
        locationManagerControl(status: status)
    }
    
    func authIconToggle(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined, .denied:
            self.chatRoomView.authIcon.image = UIImage(systemName: "location")
        case .authorizedWhenInUse:
            self.chatRoomView.authIcon.image = UIImage(systemName: "location.fill")
        default:
            self.chatRoomView.authIcon.image = UIImage(systemName: "location")
        }
    }
    
    func locationManagerControl(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            showLocationSettingAlert()
        case .authorizedWhenInUse:
            
            locationManager.startUpdatingLocation()
        default: print(#function, status)
        }
    }
}


extension NowWeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        if let coordinate = locations.last?.coordinate {
            print(#function, coordinate)
            requestOpenWeatherAPI(lat: coordinate.latitude, lon: coordinate.longitude)
        }
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(#function, error)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkDeviceLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkDeviceLocationAuthorization()
    }
}


extension NowWeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
        
        guard let foreCast = self.chatRoomView.hereWeather?.list.first else {
            return cell
        }
        var data = ""
        switch indexPath.row {
        case 0: data = String(round(foreCast.main.temp - 273.15))
        case 1: data = String(foreCast.main.humidity)
        case 2: data = String(round(foreCast.wind.speed))
        default: data = "행복한 하루 보내세요"
        }
        
        cell.configCell(row: indexPath.row, data: data)
        
        return cell
    }
}



