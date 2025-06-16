//
//  MovieAppMVVMTests.swift
//  MovieAppMVVMTests
//
//  Created by iMacRaja on 14/06/25.
//

import Testing
@testable import MovieAppMVVM


import XCTest
@testable import MovieAppMVVM

 
final class FavoriteListViewModelTests: XCTestCase {
    var mockStorage: MockFavoritesStorage!
    var viewModel: FavoriteListViewModel!
    
    override func setUp() {
        super.setUp()
        mockStorage = MockFavoritesStorage()
        viewModel = FavoriteListViewModel(storage: mockStorage)
    }
    
    
    func test_load_fetchesFavoritesFromStorage() {
        let movie = Movie(id: 1, title: "Inception", releaseDate: nil, posterPath: nil, overview: nil)
        mockStorage.storedMovies = [movie]
        
        let expectation = expectation(description: "Favorites loaded")
        var isFulfilled = false
        
        viewModel.onFavoritesChanged = {
            if !isFulfilled {
                isFulfilled = true
                XCTAssertEqual(self.viewModel.count, 1)
                XCTAssertEqual(self.viewModel.movie(at: 0).title, "Inception")
                expectation.fulfill()
            }
        }
        
        viewModel.load()
        wait(for: [expectation], timeout: 1.0)
    }
    
    
    
    func test_emptyFavorites_returnsZeroCount() {
        mockStorage.storedMovies = []
        viewModel.load()
        XCTAssertEqual(viewModel.count, 0)
    }
}

