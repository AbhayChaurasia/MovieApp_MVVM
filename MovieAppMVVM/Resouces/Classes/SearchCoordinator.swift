//
//  SearchCoordinator.swift
//  MovieAppMVVM
//
//  Created by Abhay Chaurasia on 16/06/25.
//
import UIKit
class SearchCoordinator {
    weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    func showMovieDetails(for movie: Movie) {
        let vm = MovieDetailsViewModel(movie: movie)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "MovieDetailsViewController") as! MovieDetailsViewController
        
            vc.viewModel = vm
        navigationController?.pushViewController(vc, animated: true)
    }

    func showFavoriteList() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "FavoriteListViewController") as! FavoriteListViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}
