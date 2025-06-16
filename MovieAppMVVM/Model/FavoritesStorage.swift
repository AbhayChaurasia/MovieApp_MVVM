//
//  Untitled.swift
//  MovieAppMVVM
//
//  Created by Abhay on 14/06/25.
//

import CoreData
import UIKit



protocol FavoritesStorageProtocol {
    func isFavorite(movieID: Int) -> Bool
    func add(movie: Movie)
    func remove(movieID: Int)
    
    func fetchAll() -> [Movie]
}
extension FavoritesStorageProtocol {
    func fetchAll() -> [Movie] {
        return []
    }
}
class FavoritesStorage  : FavoritesStorageProtocol{
    static let shared = FavoritesStorage()
    
    private let context: NSManagedObjectContext
    
    private init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.context = appDelegate.persistentContainer.viewContext
    }
    
    func isFavorite(movieID: Int) -> Bool {
        let fetch = NSFetchRequest<FavouriteMovieEntity>(entityName: "FavouriteMovieEntity")
        fetch.predicate = NSPredicate(format: "id == %d", movieID)
        return (try? context.count(for: fetch)) ?? 0 > 0
    }
    
    func add(movie: Movie) {
        guard !isFavorite(movieID: movie.id) else { return }
        let entity = FavouriteMovieEntity(context: context)
        entity.id = Int32(movie.id)
        entity.title = movie.title
        entity.posterPath = movie.posterPath
        entity.overview =   "" //movie.overview
        entity.releaseDate = movie.releaseDate
        save()
    }
    
    func remove(movieID: Int) {
        let fetch = NSFetchRequest<FavouriteMovieEntity>(entityName: "FavouriteMovieEntity")
        fetch.predicate = NSPredicate(format: "id == %d", movieID)
        if let results = try? context.fetch(fetch) {
            for obj in results {
                context.delete(obj)
            }
        }
        save()
    }
    
    func fetchAll() -> [Movie] {
        let fetch = NSFetchRequest<FavouriteMovieEntity>(entityName: "FavouriteMovieEntity")
        guard let results = try? context.fetch(fetch) else { return [] }
        return results.map { entity in
            Movie(
                id: Int(entity.id),
                title: entity.title ?? "",
                releaseDate: entity.releaseDate,
                posterPath: entity.posterPath,
                overview: entity.overview
            )
        }
    }
    
    private func save() {
        if context.hasChanges {
            try? context.save()
        }
    }
    
    
}

