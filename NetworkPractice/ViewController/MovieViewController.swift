//
//  MovieViewController.swift
//  NetworkPractice
//
//  Created by 박성민 on 6/6/24.
//

import UIKit

import Alamofire
import SnapKit

class MovieViewController: UIViewController {
    let dateTextField = UITextField()
    let line = UIView()
    let searchButton = UIButton()
    
    let movieTableView = UITableView()
    
    var movieList = [DailyMovieModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpHierarch()
        setUpLayout()
        setUpUI()
        setUpMovieTableViw()
        callRequest(turn: "20240601")
    }
    
    // MARK: - connect 부분
    func setUpHierarch() {
        view.addSubview(dateTextField)
        view.addSubview(line)
        view.addSubview(searchButton)
        view.addSubview(movieTableView)
        
    }
    
    // MARK: - Layout 부분
    func setUpLayout() {
        dateTextField.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.trailing.equalTo(searchButton.snp.leading).offset(-10)
            make.height.equalTo(40)
        }
        line.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.top.equalTo(dateTextField.snp.bottom).offset(5)
            make.trailing.equalTo(searchButton.snp.leading).offset(-10)
            make.height.equalTo(3)
        }
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.height.equalTo(50)
            make.width.equalTo(80)
        }
        movieTableView.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    // MARK: - movieTableView 세팅 부분
    func setUpMovieTableViw() {
        movieTableView.dataSource = self
        movieTableView.delegate = self
    }
    // MARK: - UI 세팅 부분
    func setUpUI() {
        view.backgroundColor = .black
        
        dateTextField.backgroundColor = .red
        
        line.backgroundColor = .white
        
        searchButton.backgroundColor = .white
        
        
    }
    
    
    // MARK: - 통신 부분
    func callRequest(turn: String) {
        APIKey.movieURL = turn
        AF.request(APIKey.movieURL).responseDecodable(of: [DailyMovieModel].self) { respons in
            switch respons.result{
            case .success(let data):
                self.movieList = data
            case .failure(let error):
                dump(error)
                
            }
        }
    }
    
}

// TODO: 테이블 뷰 세팅
extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}