//
//  WeatherTableViewCell.swift
//  HereWeather
//
//  Created by 유철원 on 6/19/24.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // MarketTableViewCell의 contentView에 추가하는 코드
        configHierarchy()
        configLayout()
        configUI()
        configCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configHierarchy() {
        
    }
    
    func configLayout() {
        
    }
    
    func configUI() {
        
    }
    
    func configCell() {
        
    }
}
