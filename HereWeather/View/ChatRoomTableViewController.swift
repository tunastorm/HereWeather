//
//  ChatRoomTableViewController.swift
//  HereWeather
//
//  Created by 유철원 on 6/19/24.
//

import UIKit

import SnapKit
import Then


class ChatRoomTableViewController: UIViewController {

    let dateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15)
    }
    
    let infoView = UIView()
    
    let authIcon = UIImageView().then {
        $0.tintColor = .white
    }
    
    let cityLabel = UILabel()
    
    let shareButton = UIButton()
    
    let reloadButton = UIButton()
    
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configHierarchy()
        configLayout()
        setTableView()
        configUI()
        
    }
    
    func configHierarchy() {
        view.addSubview(dateLabel)
        view.addSubview(infoView)
        infoView.addSubview(authIcon)
        infoView.addSubview(cityLabel)
        infoView.addSubview(shareButton)
        infoView.addSubview(reloadButton)
        view.addSubview(tableView)
    }
    
    func configLayout() {
        dateLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.width.equalTo(200)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(40)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        infoView.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.top.equalTo(dateLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(infoView.snp.bottom)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        authIcon.snp.makeConstraints {
            $0.size.equalTo(50)
            $0.verticalEdges.equalToSuperview().inset(5)
            $0.leading.equalToSuperview()
        }
        
        cityLabel.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.verticalEdges.equalToSuperview().inset(5)
            $0.leading.equalTo(authIcon.snp.trailing).offset(20)
        }
        
        shareButton.snp.makeConstraints {
            $0.size.equalTo(50)
            $0.verticalEdges.equalToSuperview().inset(5)
            $0.leading.equalTo(cityLabel.snp.trailing).offset(20)
        }
        
        reloadButton.snp.makeConstraints {
            $0.size.equalTo(50)
            $0.verticalEdges.equalToSuperview().inset(5)
            $0.leading.equalTo(shareButton.snp.trailing).offset(20)
            $0.trailing.equalToSuperview()
        }
    }
    
    func configUI() {
        view.backgroundColor = .systemBrown
    }
    
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: WeatherTableViewCell.identifier)
    }
}


extension ChatRoomTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
        
        cell.backgroundColor = .white
        
        return cell
    }
}
