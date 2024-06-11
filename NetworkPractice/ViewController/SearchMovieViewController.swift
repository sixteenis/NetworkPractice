//
//  SearchMovieViewController.swift
//  NetworkPractice
//
//  Created by 박성민 on 6/11/24.
//

import UIKit

import SnapKit
import Alamofire

class SearchMovieViewController: UIViewController {
    let searchBar = UISearchBar()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectioViewLayout())
    static func collectioViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - 40
        layout.itemSize = CGSize(width: width/3, height: width/2) //셀
        layout.scrollDirection = .vertical // 가로, 세로 스크롤 설정
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)//전체의 기준?
        return layout
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpHierarch()
        setUpLayout()
        setUpUI()
        setUpCollectionView()
        callRequset()
    }
    var page = 1
    var isEnd = 1
    var movieName = "범죄도시"
    var list = [MovieModel]() {
        willSet{
            collectionView.reloadData()
        }
    }
    
    // MARK: - connect 부분
    func setUpHierarch() {
        view.addSubview(searchBar)
        view.addSubview(collectionView)
    }
    
    // MARK: - Layout 부분
    func setUpLayout() {
        searchBar.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    // MARK: - UI 세팅 부분
    func setUpUI() {
        view.backgroundColor = .white
        
    }
    func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SearchMovieCollectionViewCell.self, forCellWithReuseIdentifier: "SearchMovieCollectionViewCell")
        collectionView.backgroundColor = .white
    }
    // MARK: - 통신 부분
    func callRequset() {
        let url = "https://api.themoviedb.org/3/search/movie"
        let header: HTTPHeaders = [
            "Authorization": APIKey.movieKey
            //"Content-Type":"application/json"
        ]
        let param: Parameters = [
            "query": movieName,
            "page": page
            //"size": 20
            //"max_tokens": 100
        ]
        AF.request(url,method: .get,parameters: param, headers: header)
            .responseDecodable(of: MovieListModel.self) { [self] respons in
                switch respons.result{
                case .success(let value):
                    //isEnd = value.page
                    if page == 1 || self.searchBar.text! != movieName{
                        self.list = value.results
                        
                    }
                    else{
                        self.list.append(contentsOf: value.results)
                    }
                    //self.tableView.reloadData()
                    
                case .failure(let error):
                    print("실패")
                    print(error)
                }
                movieName = self.searchBar.text!
            }
    }

}

extension SearchMovieViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchMovieCollectionViewCell", for: indexPath) as! SearchMovieCollectionViewCell
        let data = list[indexPath.row]
        cell.setUpData(data: data)
        cell.movieImage.backgroundColor = .red
        cell.backgroundColor = .white
        return cell
    }
    
    
}

extension SearchMovieViewController: UISearchBarDelegate {
    
}
