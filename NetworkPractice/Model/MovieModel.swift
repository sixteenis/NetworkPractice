//
//  MovieModel.swift
//  NetworkPractice
//
//  Created by 박성민 on 6/11/24.
//

import Foundation

struct MovieListModel:Decodable {
    let page: Int
    let results: [MovieModel]
    let total_pages: Int
}
struct MovieModel:Decodable {
    //let id: Int
    let poster_path: String?
}

//{
//            "adult": false,
//            "backdrop_path": "/ca0E776V4Z86Smvvd0842p43hjL.jpg",
//            "genre_ids": [
//                53,
//                80,
//                18,
//                27
//            ],
//            "id": 59421,
//            "original_language": "ko",
//            "original_title": "김복남 살인사건의 전말",
//            "overview": "A woman subject to mental, physical, and sexual abuse on a remote island seeks a way out.",
//            "popularity": 12.205,
//            "poster_path": "/uqvG28xhk34ExPZYu2wRGmKB34h.jpg",
//            "release_date": "2010-08-19",
//            "title": "Bedevilled",
//            "video": false,
//            "vote_average": 7.165,
//            "vote_count": 386
//        },
