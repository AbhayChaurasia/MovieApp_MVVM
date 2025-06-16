//
//  MovieAppMVVMTests.swift
//  MovieAppMVVMTests
//
//  Created by Abhay on 14/06/25.
//


import XCTest
@testable import MovieAppMVVM

final class MovieDetailsViewControllerTests: XCTestCase {
    var sut: MovieDetailsViewController!
    var mockViewModel: MockMovieDetailsViewModel!

    override func setUp() {
        super.setUp()

        // Load from storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController

        // Set mock view model before view loads
        let movie = Movie(id: 1, title: "Inception", releaseDate: nil, posterPath: nil, overview: "Dream within a dream.")
        mockViewModel = MockMovieDetailsViewModel(movie: movie)
        sut.viewModel = mockViewModel

        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        sut = nil
        mockViewModel = nil
        super.tearDown()
    }

    // MARK: - Tests

    func test_viewDidLoad_setsMovieDataCorrectly() {
        XCTAssertEqual(sut.titleLabel.text, "Inception")
        XCTAssertTrue(sut.overviewLabel.text?.contains("Dream within a dream.") ?? false)
        XCTAssertEqual(sut.favoriteButton.title(for: .normal), "Favorite")
    }

    func test_favoriteButtonTapped_callsToggleFavorite() {
        sut.favoriteButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(mockViewModel.toggleCalled)
    }

    func test_onFavoriteStatusChanged_updatesButtonTitle() {
        mockViewModel.isFavorite = true
        mockViewModel.onFavoriteStatusChanged?()
        XCTAssertEqual(sut.favoriteButton.title(for: .normal), "Unfavorite")
    }
}

 
