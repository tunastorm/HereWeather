//
//  WeatherTableViewCell.swift
//  HereWeather
//
//  Created by 유철원 on 6/19/24.
//

import UIKit

import SnapKit
import Then


class WeatherTableViewCell: UITableViewCell {
    
    let bubbleView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 6
        $0.layer.masksToBounds = true
    }
    
    let chatLabel = UILabel()
   
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configHierarchy()
        configLayout()
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configHierarchy() {
        contentView.addSubview(bubbleView)
        bubbleView.addSubview(chatLabel)
    }
    
    func configLayout() {
        bubbleView.snp.makeConstraints {
            $0.height.equalTo(34)
            $0.leading.verticalEdges.equalToSuperview().inset(6)
            $0.trailing.lessThanOrEqualToSuperview().inset(20)
        }
        
        chatLabel.snp.makeConstraints {
            $0.height.equalTo(26)
            $0.edges.equalToSuperview().inset(4)
        }
        
    }
    
    func configUI() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
    
    func configCell(row: Int, data: String) {
        var text = ""
        switch row {
        case 0: text = "지금은 \(data)˚C 에요"
        case 1: text = "\(data)% 만큼 습해요"
        case 2: text = "\(data)m/s의 바람이 불어요"
        default: text = data
        }
        chatLabel.text = text
    }
}
