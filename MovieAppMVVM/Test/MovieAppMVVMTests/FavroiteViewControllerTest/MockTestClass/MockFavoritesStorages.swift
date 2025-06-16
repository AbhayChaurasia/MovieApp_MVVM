//
//  MockFavoritesStorages.swift
//  MovieAppMVVM
//
//  Created by iMacRaja on 16/06/25.
//

 
class MockFavoritesStorage: FavoritesStorageProtocol {
    var storedMovies: [Movie]
    
    init(storedMovies: [Movie] = []) {
        self.storedMovies = storedMovies
    }
    
    func isFavorite(movieID: Int) -> Bool {
        return storedMovies.contains { $0.id == movieID }
    }
    
    func add(movie: Movie) {
        storedMovies.append(movie)
    }
    
    func remove(movieID: Int) {
        storedMovies.removeAll { $0.id == movieID }
    }
    
    func fetchAll() -> [Movie] {
        return storedMovies
    }
}


//viewcontroller mocking class
class MockFavoriteListViewModel: FavoriteListViewModelProtocol {
    var count: Int = 0
    var movies: [Movie] = []
    var loadCalled = false
    var onFavoritesChanged: (() -> Void)?

    func movie(at index: Int) -> Movie {
        return movies[index]
    }

    func load() {
        loadCalled = true
        onFavoritesChanged?()
    }
}
