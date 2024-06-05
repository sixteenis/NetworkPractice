//
//  MovieTableViewCell.swift
//  NetworkPractice
//
//  Created by 박성민 on 6/6/24.
//

import UIKit

import SnapKit

class MovieTableViewCell: UITableViewCell {
    let backView = UIView()
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
        contentView.addSubview(backView)
        backView.addSubview(rankLabel)
        contentView.addSubview(movieTitleLabel)
        contentView.addSubview(dateLabel)
    }
    
    // MARK: - Layout 부분
    func setUpLayout() {
        backView.snp.makeConstraints { make in
            make.bottom.top.equalTo(contentView.safeAreaLayoutGuide).inset(15)
            make.leading.equalTo(contentView.safeAreaLayoutGuide)
            make.width.equalTo(50)
        }
        rankLabel.snp.makeConstraints { make in
            make.center.equalTo(backView)
        }
        movieTitleLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView.safeAreaLayoutGuide)
            make.leading.equalTo(backView.snp.leading).inset(60)
            make.trailing.equalTo(dateLabel.snp.leading).inset(60)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.bottom.trailing.equalTo(contentView.safeAreaLayoutGuide)
            make.width.equalTo(80)
        }
    }
    
    // MARK: - UI 세팅 부분
    func setUpUI() {
        contentView.backgroundColor = .systemCyan
        
        backView.backgroundColor = .white
        //rankLabel.backgroundColor = .white
        rankLabel.font = .boldSystemFont(ofSize: 16)
        rankLabel.contentMode = .right
        rankLabel.textColor = .black
        
        movieTitleLabel.backgroundColor = .systemCyan
        movieTitleLabel.font = .boldSystemFont(ofSize: 16)
        movieTitleLabel.textAlignment = .left
        movieTitleLabel.numberOfLines = 1
        movieTitleLabel.textColor = .white
        
        dateLabel.backgroundColor = .systemCyan
        dateLabel.font = .systemFont(ofSize: 13)
        dateLabel.textColor = .white
    }
    func setUpData(data: DailyBoxOfficeList) {
        rankLabel.text = data.rank
        
        movieTitleLabel.text = "   \(data.movieNm)"
        
        dateLabel.text = data.openDt
    }
}

