//
//  MockMovieSearchService.swift
//  MovieAppMVVM
//
//  Created by iMacRaja on 14/06/25.
//

import Foundation

 
struct MockService: MovieSearchService {
    
    enum Mode {
        case success([Movie])
        case failure(Error)
    }
    let mode: Mode
    init(mode: Mode) {
           self.mode = mode
       }

    func searchMovies(query: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        switch mode {
        case .success(let movies):
            completion(.success(movies))
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
}
class MockSearchMovieViewModel: SearchMovieViewModelProtocol {
    var onLoadingChanged: ((Bool) -> Void)?

    var count: Int = 0
    var searchCalled = false
    var searchQuery: String?
    var onMoviesUpdated: (() -> Void)?
    var onError: ((String) -> Void)?
    
    var movies: [Movie] = []
    
    func search(query: String) {
        searchCalled = true
        searchQuery = query
        onMoviesUpdated?()
    }
    
    func retriveMovie(withId id: Int) -> Movie? {
        return movies.first(where: { $0.id == id })
    }
}

class MockSearchCoordinator: SearchCoordinator {
    var didShowFavorites = false
    var didShowMovieDetails = false
    var moviePassedToDetails: Movie?
    
    override func showFavoriteList() {
        didShowFavorites = true
    }
    
    override func showMovieDetails(for movie: Movie) {
        didShowMovieDetails = true
        moviePassedToDetails = movie
    }
}
