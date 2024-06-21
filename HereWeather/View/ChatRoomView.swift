//
//  ChatRoomTableViewController.swift
//  HereWeather
//
//  Created by 유철원 on 6/19/24.
//

import UIKit

import SnapKit
import Then


class ChatRoomView: UIView {
    
    var delegate: chatRoomDelegate?
    
    var hereWeather: OpenWeatherResponse? {
        didSet {
            print(#function, hereWeather)
            configDateAndCity()
            tableView.reloadData()
        }
    }
    
    let dateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15)
        $0.textColor = .white
        $0.textAlignment = .left
    }
    
    let infoView = UIView()
    
    let authIcon = UIImageView().then {
        $0.tintColor = .white
        $0.contentMode = .scaleAspectFit
    }
    
    let cityLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 25)
        $0.textColor = .white
        $0.textAlignment = .left
    }
    
    let shareButton = UIButton().then {
        $0.setImage(UIImage(systemName: "square.and.arrow.up")?.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.tintColor = .white
        $0.contentMode = .scaleAspectFit
    }
    
    let reloadButton = UIButton().then {
        $0.setImage(UIImage(systemName: "arrow.clockwise")?.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.tintColor = .white
        $0.addTarget(self, action: #selector(updateResponse), for: .touchUpInside)
    }
    
    let tableView = UITableView()
    
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        configHierarchy()
        configLayout()
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configHierarchy() {
        self.addSubview(dateLabel)
        self.addSubview(infoView)
        infoView.addSubview(authIcon)
        infoView.addSubview(cityLabel)
        infoView.addSubview(shareButton)
        infoView.addSubview(reloadButton)
        self.addSubview(tableView)
    }
    
    func configLayout() {
        dateLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.width.equalTo(200)
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        
        infoView.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.top.equalTo(dateLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(infoView.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        authIcon.snp.makeConstraints {
            $0.size.equalTo(40)
            $0.verticalEdges.equalToSuperview().inset(5)
            $0.leading.equalToSuperview()
        }
        
        cityLabel.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.verticalEdges.equalToSuperview().inset(5)
            $0.leading.equalTo(authIcon.snp.trailing).offset(20)
        }
        
        shareButton.snp.makeConstraints {
            $0.size.equalTo(40)
            $0.verticalEdges.equalToSuperview().inset(5)
            $0.leading.equalTo(cityLabel.snp.trailing).offset(20)
        }
        
        reloadButton.snp.makeConstraints {
            $0.size.equalTo(40)
            $0.verticalEdges.equalToSuperview().inset(5)
            $0.leading.equalTo(shareButton.snp.trailing).offset(20)
            $0.trailing.equalToSuperview()
        }
    }
    
    func configUI() {
        self.backgroundColor = .systemBrown
        self.tableView.backgroundColor = .clear
        self.tableView.separatorStyle = .none
    }
    
    @objc func updateResponse() {
        print(#function)
        delegate?.checkDeviceLocationAuthorization()
    }
    
    func configDateAndCity() {
        self.cityLabel.text = hereWeather?.city.name
        guard let foreCast = hereWeather?.list.first else {
            return
        }
        self.dateLabel.text = foreCast.date
    }
}

