//
//  SearchMovieCollectionViewCell.swift
//  NetworkPractice
//
//  Created by 박성민 on 6/11/24.
//

import UIKit

import SnapKit
import Kingfisher

class SearchMovieCollectionViewCell: UICollectionViewCell {
    let movieImage = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpHierarch()
        setUpLayout()
        setUpUI()
        backgroundColor = .darkGray
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    // MARK: - connect 부분
    func setUpHierarch() {
        contentView.addSubview(movieImage)
    }
    
    // MARK: - Layout 부분
    func setUpLayout() {
        movieImage.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - UI 세팅 부분 (정적)
    func setUpUI() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 20
        contentView.backgroundColor = .white
        
        movieImage.backgroundColor = .white
        movieImage.clipsToBounds = true
        movieImage.layer.cornerRadius = 20
        movieImage.tintColor = .black
        movieImage.contentMode = .scaleAspectFill
    }
    
    // MARK: - 동적인 세팅 부분
    func setUpData(data: MovieModel) {
        guard let image = data.poster_path else {
            movieImage.image = UIImage(systemName: "person.crop.circle")
            return}
        let url = URL(string:"https://image.tmdb.org/t/p/w500\(image)")
        movieImage.kf.setImage(with: url)
    }
}
