//
//  SearchMovieViewController.swift
//  MovieAppMVVM
//
//  Created by iMacRaja on 14/06/25.
//

import UIKit

class SearchMovieViewController: UIViewController , AlertPresentable {
    
    @IBOutlet weak var searchBarBackView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    var viewModel: SearchMovieViewModelProtocol?
    var coordinator: SearchCoordinator?
    override func viewDidLoad(){
        super.viewDidLoad()
        setUpUI()
        bindViewModel()
        setRightBarButton()
        setupActivityIndicator()
    }
    
    private func setupActivityIndicator() {
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
    }
    
    
    private func bindViewModel() {
       
        
        viewModel?.onLoadingChanged = { [weak self] (isLoading: Bool) in
            if isLoading {
                self?.activityIndicator.startAnimating()
            } else {
                self?.activityIndicator.stopAnimating()
            }
        }
        viewModel?.onMoviesUpdated = { [weak self] in
            guard let self = self else { return }
            self.activityIndicator.stopAnimating()
            self.reloadTableView()
        }
        viewModel?.onError = { [weak self] errorMessage in
            self?.showAlert(title: "Error", message: errorMessage)
        }
        
        
    }
    
    
    private func setRightBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Favorite Movie",
            style: .plain,
            target: self,
            action: #selector(favoriteTapped)
        )
    }
    @objc  func favoriteTapped() {
        let favorites = FavoritesStorage.shared.fetchAll()
        
        if !favorites.isEmpty {
            coordinator?.showFavoriteList()
        } else {
            self.showAlert(title: "No Favorites", message: "You don't have any favorite movies yet.")
            
        }
    }
    
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        
        let query = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        viewModel?.search(query: query)
        searchBar.resignFirstResponder()
    }
    
    
    func openDetails(movieId: Int) {
        guard let movie = viewModel?.retriveMovie(withId: movieId) else {
            return
        }
        coordinator?.showMovieDetails(for: movie)
        
    }
    
}




