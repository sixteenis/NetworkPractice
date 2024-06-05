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
    
    var movieList = [DailyBoxOfficeList]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpHierarch()
        setUpLayout()
        setUpUI()
        setUpMovieTableViw()
        callRequest(turn: "20240601")
        setUpTarget()
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
            make.height.equalTo(4)
        }
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-10)
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
        movieTableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.id)
        movieTableView.rowHeight = 60
        movieTableView.backgroundColor = .systemCyan
        movieTableView.separatorStyle = .none
    }
    // MARK: - UI 세팅 부분
    func setUpUI() {
        view.backgroundColor = .systemCyan
        
        dateTextField.textColor = .white
        dateTextField.placeholder = "날짜 입력 ex)20240101"
        dateTextField.font = .systemFont(ofSize: 13)
        
        
        line.backgroundColor = .white
        
        searchButton.backgroundColor = .white
        searchButton.setTitle("검색", for: .normal)
        searchButton.setTitleColor(.black, for: .normal)
        
        
    }
    
    // MARK: - 버튼 설정 부분
    func setUpTarget() {
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    @objc func searchButtonTapped() {
        if !dateTextField.text!.isEmpty && Int(dateTextField.text!) != nil && dateTextField.text!.count == 8 {
            callRequest(turn: dateTextField.text!)
        }
    }
    
    // MARK: - 통신 부분
    func callRequest(turn: String) {
        APIKey.movieURL = turn
        AF.request(APIKey.movieURL).responseDecodable(of: DailyMovieModel.self) { respons in
            switch respons.result{
            case .success(let data):
                self.succesNetworkAndSetView(movies: data)
            case .failure(let error):
                dump(error)
                
            }
        }
    }
    // MARK: - 네트워크 진행 후 값을 통해 뷰 업데이트 함수
    func succesNetworkAndSetView(movies: DailyMovieModel) {
        movieList = movies.boxOfficeResult.dailyBoxOfficeList
        movieTableView.reloadData()
    }
    
}


// TODO: 테이블 뷰 세팅
extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = movieTableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.id, for: indexPath) as! MovieTableViewCell
        let data = movieList[indexPath.row]
        dump(data)
        cell.setUpData(data: data)
        
        return cell
    }
}
