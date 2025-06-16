//
//  SearchMovieViewModel.swift
//  MovieAppMVVM
//
//  Created by iMacRaja on 14/06/25.
//

import Foundation


protocol SearchMovieViewModelProtocol: AnyObject {
    
    func retriveMovie(withId id: Int) -> Movie?
    var onLoadingChanged: ((Bool) -> Void)? { get set }
    
    var movies: [Movie] { get }
    func search(query: String)
    func movie(at index: Int) -> Movie
    var count: Int { get }
    var onMoviesUpdated: (() -> Void)? { get set }
    var onError: ((String) -> Void)? { get set }
    
}

class SearchMovieViewModel  : SearchMovieViewModelProtocol {
    private let service: MovieSearchService
    var viewModel: SearchMovieViewModelProtocol!
    var coordinator: SearchCoordinator?
    var onMoviesUpdated: (() -> Void)?
    var onError: ((String) -> Void)?
    var onLoadingChanged: ((Bool) -> Void)?
    private(set) var movies: [Movie] = []
    
    init(service: MovieSearchService) {
        self.service = service
    }
    
    
    
    func search(query: String) {
        guard !query.isEmpty else {
            self.movies = []
            onMoviesUpdated?()
            onError?("Search query cannot be empty.")
            onLoadingChanged?(false)
            return
        }
        
        onLoadingChanged?(true)
        
        service.searchMovies(query: query) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.onLoadingChanged?(false)
                switch result {
                case .success(let movies):
                    self.movies = movies
                    
                    if movies.isEmpty {
                        self.movies = []
                        self.onError?("Movie name not found")
                        self.onMoviesUpdated?()
                    } else {
                        self.movies = movies
                        self.onMoviesUpdated?()
                    }
                case .failure(let error):
                    self.movies = []  // ✅ Clear old data on error
                    self.onMoviesUpdated?()
                    self.onError?(error.localizedDescription)
                }
            }
        }
    }
    
    func clearResults() {
        movies = []
        onMoviesUpdated?()
    }
    func movie(at index: Int) -> Movie {
        return movies[index]
    }
    
    var count: Int {
        return movies.count
    }
    
    func retriveMovie(withId id: Int) -> Movie? {
        guard let movie = movies.first(where: {$0.id == id}) else {
            return nil
        }
        
        return movie
    }
}
extension SearchMovieViewModelProtocol {
    func movie(at index: Int) -> MovieAppMVVM.Movie {
        return movies[index]
    }
    
}
