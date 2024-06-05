//
//  DailyMovieModel.swift
//  NetworkPractice
//
//  Created by 박성민 on 6/6/24.
//

import Foundation

struct DailyMovieModel: Decodable{
    let rank: String
    let movieNm: String
    let openDt: String
}
