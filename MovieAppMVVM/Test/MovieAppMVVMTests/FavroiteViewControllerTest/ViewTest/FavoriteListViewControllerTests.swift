//
//  MovieAppMVVMTests.swift
//  MovieAppMVVMTests
//
//  Created by iMacRaja on 14/06/25.
//

 


import XCTest
@testable import MovieAppMVVM
 

final class FavoriteListViewControllerTests: XCTestCase {
    var sut: FavoriteListViewController!
    var mockViewModel: MockFavoriteListViewModel!

    override func setUp() {
        super.setUp()

        // Load ViewController from storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: "FavoriteListViewController") as? FavoriteListViewController

        // Inject mock view model
        mockViewModel = MockFavoriteListViewModel()
        mockViewModel.movies = [
            Movie(id: 1, title: "Inception", releaseDate: nil, posterPath: nil, overview: nil)
        ]
        mockViewModel.count = mockViewModel.movies.count

        sut.viewModel = mockViewModel

        // Trigger view loading
        _ = sut.view
    }

    override func tearDown() {
        sut = nil
        mockViewModel = nil
        super.tearDown()
    }

    func test_viewWillAppear_callsLoad() {
        sut.viewWillAppear(false)
        XCTAssertTrue(mockViewModel.loadCalled)
    }

    func test_onFavoritesChanged_reloadTable() {
        let tableView = sut.tableView!
        let expectation = expectation(description: "table reloaded")

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            XCTAssertEqual(self.sut.tableView.numberOfRows(inSection: 0), 1)
            expectation.fulfill()
        }

        // Trigger reload
        mockViewModel.onFavoritesChanged?()
        wait(for: [expectation], timeout: 1)
    }
}

