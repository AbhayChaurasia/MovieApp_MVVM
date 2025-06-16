//
//  MoviewSearchService.swift
//  MovieAppMVVM
//
//  Created by Abhay on 14/06/25.
//

import Foundation

protocol MovieSearchService {
    func searchMovies(query: String, completion: @escaping (Result<[Movie], Error>) -> Void)
}

class TMDbMovieSearchService: MovieSearchService {
    
    private let config: APIConfiguration
    private let session: URLSession
    
    init(config: APIConfiguration, session: URLSession = .shared) {
        self.config = config
        let config = URLSessionConfiguration.ephemeral
        let sessions = URLSession(configuration: config)
        self.session = sessions
        // self.session = session
    }
    
    func searchMovies(query: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        
        
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "\(config.baseURL)?api_key=\(config.apiKey)&query=\(encodedQuery)") else {
            return completion(.failure(NSError(domain: "InvalidURL", code: 0)))
        }
        print("Service urk is ==\(url)")
        
        session.dataTask(with: url) { data, response, error in
            
            if let nsError = error as NSError? {
                      if nsError.domain == NSURLErrorDomain && nsError.code == NSURLErrorNotConnectedToInternet {
                          return completion(.failure(NetworkError.noInternet))
                      }
                      return completion(.failure(nsError))
                  }
            if let error = error {
                print(error.localizedDescription)
                return completion(.failure(error))
            }
            
            guard let data = data else {
                return completion(.failure(NSError(domain: "NoData", code: 0)))
            }
            
            do {
                
                let decoded = try JSONDecoder().decode(MovieSearchResponse.self, from: data)
                completion(.success(decoded.results))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
}





enum NetworkError: Error {
    case invalidURL
    case noInternet
    case noData
}
