//
//  NowWeatherTableViewController.swift
//  HereWeather
//
//  Created by 유철원 on 6/21/24.
//

import UIKit

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

