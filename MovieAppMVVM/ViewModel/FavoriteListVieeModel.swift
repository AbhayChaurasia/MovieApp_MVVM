//
//  Untitled.swift
//  MovieAppMVVM
//
//  Created by Abhay Chaurasia on 15/06/25.
//

 
import Foundation


protocol FavoriteListViewModelProtocol {
    var count: Int { get }
    func movie(at index: Int) -> Movie
    func load()
    var onFavoritesChanged: (() -> Void)? { get set }
}

//final class FavoriteListViewModel {
//    @Published private(set) var movies: [Movie] = []
//    var onFavoritesChanged: (() -> Void)?
//
//    func load() {
//        movies = FavoritesStorage.shared.fetchAll()
//        onFavoritesChanged?()
//    }
//
//    func movie(at index: Int) -> Movie { movies[index] }
//    var count: Int { movies.count }
//
//    /// Listen for add/remove events broadcast from MovieDetailsViewModel
//    init() {
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(handleFavoritesDidChange),
//            name: .favoritesDidChange,
//            object: nil
//        )
//    }
//
//    @objc private func handleFavoritesDidChange() { load() }
//}

extension Notification.Name {
    static let favoritesDidChange = Notification.Name("favoritesDidChange")
}
final class FavoriteListViewModel  : FavoriteListViewModelProtocol{
    @Published private(set) var movies: [Movie] = []
    var onFavoritesChanged: (() -> Void)?

    private let storage: FavoritesStorageProtocol
    init(storage: FavoritesStorageProtocol = FavoritesStorage.shared) {
        self.storage = storage

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleFavoritesDidChange),
            name: .favoritesDidChange,
            object: nil
        )
    }

    func load() {
        movies = storage.fetchAll()
        onFavoritesChanged?()
    }

    func movie(at index: Int) -> Movie { movies[index] }
    var count: Int { movies.count }

    @objc private func handleFavoritesDidChange() { load() }
}
