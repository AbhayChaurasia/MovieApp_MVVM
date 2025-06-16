//
//  MockMovieDetailsStorage.swift
//  MovieAppMVVM
//
//  Created by iMacRaja on 16/06/25.
//

// MARK: - Mock Favorites Storage
class MockMovieDetailStorage: FavoritesStorageProtocol {
     
    
    var favoriteIDs: Set<Int> = []
    var addedMovies: [Movie] = []
    var removedMovieIDs: [Int] = []

    func isFavorite(movieID: Int) -> Bool {
        return favoriteIDs.contains(movieID)
    }

    func add(movie: Movie) {
        favoriteIDs.insert(movie.id)
        addedMovies.append(movie)
    }

    func remove(movieID: Int) {
        favoriteIDs.remove(movieID)
        removedMovieIDs.append(movieID)
    }
}
class MockMovieDetailsViewModel: MovieDetailsViewModel {
    private var _isFavorite: Bool = false

    override var isFavorite: Bool {
        get { return _isFavorite }
        set { _isFavorite = newValue }
    }

    var toggleCalled = false

    override func toggleFavorite() {
        toggleCalled = true
        isFavorite.toggle()
        onFavoriteStatusChanged?()
    }
}
