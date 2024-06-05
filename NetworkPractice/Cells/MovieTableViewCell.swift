//
//  MovieTableViewCell.swift
//  NetworkPractice
//
//  Created by 박성민 on 6/6/24.
//

import UIKit

import SnapKit

class MovieTableViewCell: UITableViewCell {
    let rankLabel = UILabel()
    let movieTitleLabel = UILabel()
    let dateLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpHierarch()
        setUpLayout()
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - connect 부분
    func setUpHierarch() {
        contentView.addSubview(rankLabel)
        contentView.addSubview(movieTitleLabel)
        contentView.addSubview(dateLabel)
    }
    
    // MARK: - Layout 부분
    func setUpLayout() {
        rankLabel.snp.makeConstraints { make in
            make.leading.bottom.top.equalTo(contentView.safeAreaLayoutGuide)
            make.width.equalTo(50)
        }
        movieTitleLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView.safeAreaLayoutGuide)
            make.leading.equalTo(rankLabel.snp.trailing).offset(15)
            make.trailing.equalTo(dateLabel.snp.leading).offset(30)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.bottom.trailing.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - UI 세팅 부분
    func setUpUI() {
        rankLabel.backgroundColor = .red
        
        movieTitleLabel.backgroundColor = .blue
        
        dateLabel.backgroundColor = .red
    }
    func setUpData(data: DailyBoxOfficeList) {
        rankLabel.text = data.rank
        
        movieTitleLabel.text = data.movieNm
        
        dateLabel.text = data.openDt
    }
}

