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
        //callRequset()
    }
    var page = 1 {
        didSet{
            callRequset()
        }
    }
    var isEnd = 1
    var movieName = "" {
        didSet{
            callRequset()
        }
    }
    var list = [MovieModel]() //{
//        didSet{
//            //callRequset()
//            //collectionView.reloadData()
//        }
//    }
    
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
        view.backgroundColor = .systemBackground
        
        searchBar.delegate = self
        searchBar.placeholder = "영화 제목을 검색해 보세요."
        
        navigationItem.title = "영화 검색"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.secondaryLabel]
    }
    func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        collectionView.register(SearchMovieCollectionViewCell.self, forCellWithReuseIdentifier: SearchMovieCollectionViewCell.id)
        collectionView.backgroundColor = .systemBackground
        
    }
    // MARK: - 통신 부분
    func callRequset() {
        let url = "https://api.themoviedb.org/3/search/movie"
        let header: HTTPHeaders = [
            "Authorization": APIKey.movieKey
        ]
        let param: Parameters = [
            "query": movieName,
            "page": page
        ]
        AF.request(url,method: .get,parameters: param, headers: header)
            .responseDecodable(of: MovieListModel.self) { [self] respons in
                switch respons.result{
                case .success(let value):
                    isEnd = value.total_pages
                    print(#function)
                    if page == 1{
                        self.list = value.results.filter { $0.poster_path != nil}
                        self.collectionView.scrollsToTop = true
                    }
                    else{
                        self.list.append(contentsOf: value.results.filter { $0.poster_path != nil})
                    }
                    //collectionView.reloadData()
                case .failure(let error):
                    print("실패")
                    print(error)
                }
                collectionView.reloadData()
            }
    }

}

extension SearchMovieViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchMovieCollectionViewCell.id, for: indexPath) as! SearchMovieCollectionViewCell
        let data = list[indexPath.row]
        cell.setUpData(data: data)
        cell.movieImage.backgroundColor = .systemBackground
        cell.backgroundColor = .systemBackground
        return cell
    }
    
    
}

extension SearchMovieViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        if !searchBar.text!.isEmpty{
            self.movieName = searchBar.text!
            page = 1
            //callRequset()
        }
        
    }
}
extension SearchMovieViewController: UICollectionViewDataSourcePrefetching{
    // cellforRowAt이 호출 되기 전에 미리 호출됨
    //즉, 셀이 화면에 보이기 직전에 필요한 리소스를 미리 다운을 받는 기능
    //호출 시점은 애플이 알아서 결정
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for item in indexPaths {
            
            if list.count - 4 == item.row && isEnd != page+1{
                page += 1
                //callRequset()
            }
        }
    }
    //취소 기능: 단, 직접 취소하는 기능을 구현을 해주어야 한다.
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print(indexPaths)
    }
    
    
    
}




