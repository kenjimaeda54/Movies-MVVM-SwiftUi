//
//  HTTPClient.swift
//  Movies
//
//  Created by kenjimaeda on 08/06/23.
//

import Foundation

enum  NetWorkError: Error {
	case badUrl
	case badDecoding
	case noData
	case error
}


class HttpClient {
	
	
	func  getMovies(search: String,completion: @escaping(Result<[MoviesModel]?,NetWorkError>) -> Void ) {
		guard	let url = URL.fromMovieByName(name: search) else {
			return completion(.failure(.badUrl))
		}
		
		
		URLSession.shared.dataTask(with: url) { data, urlResponse, error in
			
			guard let dataResponse = data, error == nil else {
				return completion(.failure(.noData))
			}
			
			
			do {
				let response = try JSONDecoder().decode(SearchModel.self, from: dataResponse)
				completion(.success(response.movies))
				
			}catch {
				print(error)
				
			}
			
		}.resume()
		
		
	}
	
	
}
