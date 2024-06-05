//
//  ReuseIdentifier+.swift
//  NetworkPractice
//
//  Created by 박성민 on 6/6/24.
//

import UIKit
protocol ReuseIdentifierProtocol {
    static var id: String { get }
}
extension ReuseIdentifierProtocol {
    static var id: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReuseIdentifierProtocol{}
extension UITableView: ReuseIdentifierProtocol{}
extension UIViewController: ReuseIdentifierProtocol{}
