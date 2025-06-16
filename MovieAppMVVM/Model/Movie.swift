//
//  Movie.swift
//  MovieAppMVVM
//
//  Created by Abhay on 14/06/25.
//


import Foundation
struct Movie: Decodable {
    let id: Int
    let title: String?
    let releaseDate: String?
    let posterPath: String?
    let overview : String?
    enum CodingKeys: String, CodingKey {
        case id, title
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case overview
    }
}
protocol MovieRepository {
    func fetchMovieDetails(id: Int,
                           completion: @escaping (Result<Movie, Error>) -> Void)
    
    func toggleFavourite(_ movie: Movie,
                         completion: @escaping (Result<Movie, Error>) -> Void)
    
    func fetchFavourites() -> [Movie]
}

struct MovieSearchResponse: Decodable {
    let results: [Movie]
}
