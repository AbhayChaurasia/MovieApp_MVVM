//
//  MovieDetailsViewModel.swift
//  MovieAppMVVM
//
//  Created by iMacRaja on 14/06/25.
//

import Foundation
import Combine

 
 
class MovieDetailsViewModel {
    let movie: Movie
    private(set) var isFavorite: Bool = false
  
    private let favoritesStorage: FavoritesStorageProtocol
    var onFavoriteStatusChanged: (() -> Void)?

    init(movie: Movie, favoritesStorage: FavoritesStorageProtocol = FavoritesStorage.shared) {
        self.movie = movie
        self.favoritesStorage = favoritesStorage
        checkFavoriteStatus()
    }

    func toggleFavorite() {
        if isFavorite {
            favoritesStorage.remove(movieID: movie.id)
        } else {
            favoritesStorage.add(movie: movie)
        }
        checkFavoriteStatus()
    }

    private func checkFavoriteStatus() {
        isFavorite = favoritesStorage.isFavorite(movieID: movie.id)
        onFavoriteStatusChanged?()
    }
}
