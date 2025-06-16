//
//  MovieAppMVVMTests.swift
//  MovieAppMVVMTests
//
//  Created by Abhay on 14/06/25.
//


import XCTest
@testable import MovieAppMVVM

final class MovieDetailsViewModelTests: XCTestCase {
    
    
    
    let sampleMovie = Movie(id: 1, title: "Titanic", releaseDate: nil, posterPath: nil, overview: "Ship.")
    
    //Confirms correct favorite state on init checking
    func test_initialState_isFavoriteFalse() {
        let mock = MockFavoritesStorage()
        let vm = MovieDetailsViewModel(movie: sampleMovie, favoritesStorage: mock)
        XCTAssertFalse(vm.isFavorite)
    }
    
    
    // Adds to favorites if not favorites
    func test_toggleFavorite_addsMovieIfNotFavorite() {
        let mockStorage = MockMovieDetailStorage()
        let viewModel = MovieDetailsViewModel(movie: sampleMovie, favoritesStorage: mockStorage)
        
        let expectation = expectation(description: "onFavoriteStatusChanged called")
        viewModel.onFavoriteStatusChanged = {
            XCTAssertTrue(viewModel.isFavorite)
            XCTAssertEqual(mockStorage.addedMovies.first?.id, self.sampleMovie.id)
            expectation.fulfill()
        }
        
        viewModel.toggleFavorite()
        
        wait(for: [expectation], timeout: 1.0)
    }
    //Removes if already favorited
    func test_toggleFavorite_removesMovieIfFavorite() {
        let mock = MockMovieDetailStorage()
        mock.favoriteIDs.insert(1) // pre-favorited
        
        let vm = MovieDetailsViewModel(movie: sampleMovie, favoritesStorage: mock)
        
        let exp = expectation(description: "Favorite status changed")
        vm.onFavoriteStatusChanged = {
            XCTAssertFalse(vm.isFavorite)
            XCTAssertEqual(mock.removedMovieIDs.first, 1)
            exp.fulfill()
        }
        
        vm.toggleFavorite()
        wait(for: [exp], timeout: 1)
    }
    
    //for ui update
    func test_onFavoriteStatusChanged_isCalled() {
        let movie = Movie(id: 4, title: "Test", releaseDate: nil, posterPath: nil, overview: nil)
        let mockStorage = MockMovieDetailStorage()
        let vm = MovieDetailsViewModel(movie: movie, favoritesStorage: mockStorage)
        
        let expectation = XCTestExpectation(description: "onFavoriteStatusChanged called")
        vm.onFavoriteStatusChanged = {
            expectation.fulfill()
        }
        
        vm.toggleFavorite()
        
        wait(for: [expectation], timeout: 1)
    }
    
}

