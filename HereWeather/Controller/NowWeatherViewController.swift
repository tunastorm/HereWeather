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


class NowWeatherViewController: UIViewController {

    let locationManager = CLLocationManager()
    
    var authorizationStatus: CLAuthorizationStatus?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocationManager()
        checkDeviceLocationAuthorization()
    }
    
    func setLocationManager() {
        locationManager.delegate = self
    }
}

extension NowWeatherViewController {
    
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
        switch status {
        case .notDetermined:
            print(#function, status.rawValue)
            locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            showLocationSettingAlert()
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        default: print(#function, status)
        }
    }
    
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
}


extension NowWeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
        print(#function)
        if let coordinate = locations.last?.coordinate {
            print(#function, coordinate)
            OpenWeatherModel.model.requestThreeHourAPI(lat: coordinate.latitude,
                                              lon: coordinate.latitude)
            
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
