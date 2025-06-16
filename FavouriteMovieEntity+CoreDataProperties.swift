//
//  FavouriteMovieEntity+CoreDataProperties.swift
//  MovieAppMVVM
//
//  Created by iMacRaja on 14/06/25.
//
//

import Foundation
import CoreData


extension FavouriteMovieEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouriteMovieEntity> {
        return NSFetchRequest<FavouriteMovieEntity>(entityName: "FavouriteMovieEntity")
    }

    @NSManaged public var id: Int32
    @NSManaged public var title: String?
    @NSManaged public var overview: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseDate: String?

}

extension FavouriteMovieEntity : Identifiable {

}

