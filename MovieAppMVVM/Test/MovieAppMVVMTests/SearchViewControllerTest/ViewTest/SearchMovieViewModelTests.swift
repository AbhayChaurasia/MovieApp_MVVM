//
//  MovieAppMVVMTests.swift
//  MovieAppMVVMTests
//
//  Created by Abhay on 14/06/25.
//
 
import XCTest
@testable import MovieAppMVVM

final class SearchMovieViewModelTests: XCTestCase {

    // MARK: - Mock Service
   

    // MARK: - Sample Movie
    var mockMovies: [Movie] {
        return [
            Movie(id: 1, title: "Inception", releaseDate: "2010-07-16", posterPath: nil, overview: "Dreams."),
            Movie(id: 2, title: "Interstellar", releaseDate: "2014-11-07", posterPath: nil, overview: "Space.")
        ]
    }

    // MARK: - Test Cases

    //    Then the ViewModel correctly updates its internal movies list,
    //    And the UI update callback (onMoviesUpdated) is triggered.
    func test_searchSuccess_populatesMovies() {
        let vm = SearchMovieViewModel(service: MockService(mode: .success(mockMovies)))

        let expectation = expectation(description: "Movies updated")
        vm.onMoviesUpdated = {
            XCTAssertEqual(vm.count, 2)
            XCTAssertEqual(vm.movie(at: 0).title, "Inception")
            expectation.fulfill()
        }

        vm.search(query: "Inception")
        wait(for: [expectation], timeout: 1)
    }

    //For Empty String
    func test_searchEmptyQuery_triggersError() {
        let vm = SearchMovieViewModel(service: MockService(mode: .success([])))

        let expectation = expectation(description: "Empty error")
        vm.onError = { msg in
            XCTAssertEqual(msg, "Search query cannot be empty.")
            expectation.fulfill()
        }

        vm.search(query: "   ")
        wait(for: [expectation], timeout: 1)
    }

    //for if .failure happend
    func test_searchFailure_triggersError() {
        enum DummyError: Error { case testFail }

        let vm = SearchMovieViewModel(service: MockService(mode: .failure(DummyError.testFail)))

        let expectation = expectation(description: "Error shown")
        vm.onError = { msg in
            XCTAssertNotNil(msg)
            expectation.fulfill()
        }

        vm.search(query: "error")
        wait(for: [expectation], timeout: 1)
    }

    func test_clearResults_emptiesMoviesArray() {
        let vm = SearchMovieViewModel(service: MockService(mode: .success(mockMovies)))
        let updateExp = expectation(description: "updated")

        vm.onMoviesUpdated = {
            XCTAssertEqual(vm.count, 2)
            vm.clearResults()
            XCTAssertEqual(vm.count, 0)
             updateExp.fulfill()
        }

        vm.search(query: "anything")
        wait(for: [updateExp], timeout: 1)
    }
    
    
    //this test check movie count is zero so show pop up error  messga
    func test_searchWithEmptyResultsTriggersError() {
        let vm = SearchMovieViewModel(service: MockService(mode: .success([])))
        
        let errorExpectation = expectation(description: "onError called")
        
        vm.onError = { message in
            XCTAssertEqual(message, "Movie name not found")
            errorExpectation.fulfill()
        }
        
        vm.search(query: "noresults")
        
        wait(for: [errorExpectation], timeout: 1.0)
    }

}
