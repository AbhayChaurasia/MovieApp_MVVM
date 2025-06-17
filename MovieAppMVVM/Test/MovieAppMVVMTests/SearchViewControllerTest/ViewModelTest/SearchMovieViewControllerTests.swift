//
//  MovieAppMVVMTests.swift
//  MovieAppMVVMTests
//
//  Created by Abhay on 14/06/25.
//


import XCTest
@testable import MovieAppMVVM



final class SearchMovieViewControllerTests: XCTestCase {
    
    var sut: SearchMovieViewController!
    var mockViewModel: MockSearchMovieViewModel!
    var mockCoordinator: MockSearchCoordinator!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: "SearchMovieViewController") as? SearchMovieViewController
        mockViewModel = MockSearchMovieViewModel()
        
        let navController = UINavigationController()
        mockCoordinator = MockSearchCoordinator(navigationController: navController)
        
        sut.viewModel = mockViewModel
        sut.coordinator = mockCoordinator
        
        // Load view
        _ = sut.view
    }
    
    func test_searchButtonTapped_callsSearchOnViewModel() {
        sut.searchBar.text = "Inception"
        sut.searchButtonTapped(UIButton())
        XCTAssertTrue(mockViewModel.searchCalled)
        XCTAssertEqual(mockViewModel.searchQuery, "Inception")
    }
    
    func test_favoriteTapped_callsCoordinator() {
        sut.favoriteTapped()
        XCTAssertTrue(mockCoordinator.didShowFavorites)
    }
    
    func test_openDetails_callsCoordinatorWithMovie() {
        let movie = Movie(id: 1, title: "Test Movie", releaseDate: nil, posterPath: nil, overview: nil)
        mockViewModel.movies = [movie]
        
        sut.openDetails(movieId: 1)
        
        XCTAssertTrue(mockCoordinator.didShowMovieDetails)
        XCTAssertEqual(mockCoordinator.moviePassedToDetails?.id, 1)
    }
    
    func test_moviesUpdated_triggersReloadOrAlert() {
        let exp = expectation(description: "onMoviesUpdated called")
        
        mockViewModel.onMoviesUpdated = {
            exp.fulfill()
        }
        
        mockViewModel.onMoviesUpdated?()
        wait(for: [exp], timeout: 1)
    }
    
    func test_error_triggersAlert() {
        let exp = expectation(description: "onError called")
        
        mockViewModel.onError = { message in
            XCTAssertEqual(message, "Some error")
            exp.fulfill()
        }
        
        mockViewModel.onError?("Some error")
        wait(for: [exp], timeout: 1)
    }
}
