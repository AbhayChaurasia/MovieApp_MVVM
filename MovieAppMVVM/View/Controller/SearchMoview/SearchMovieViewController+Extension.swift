//
//  SearchMovieViewController+Extension.swift
//  MovieAppMVVM
//
//  Created by Abhay Chaurasia on 15/06/25.
//

import Foundation
import UIKit

protocol AlertPresentable {}

extension SearchMovieViewController: UISearchBarDelegate {
    
    func setUpUI() {
        self.title = "Search Movies Name"
        self.view.backgroundColor = .systemBackground
        setupTableView()
        self.searchBarBackView.round()
        self.searchBarBackView.addBorder(color: UIColor.darkGray, width: 1.2)
        self.searchBar.placeholder = "Enter the Movie title..."
       
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .clear
        self.searchBar.delegate = self
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel?.search(query: searchBar.text ?? "")
        searchBar.resignFirstResponder()
    }
}

extension SearchMovieViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        160
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = viewModel!.movie(at: indexPath.row)
        cell.configure(with: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movieId = viewModel?.movies[indexPath.row].id else { return  }
        self.openDetails(movieId: movieId)
      
    }

    
}


extension AlertPresentable where Self: UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
