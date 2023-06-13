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
}


class HttpClient {
	
	
	func getDetailsMovieByImdbId(imdbId: String, completion: @escaping(Result<MovieDetailsModel,NetWorkError>) -> Void) {
		
		guard let url = URL.fromMovieDetailsbyImdbId(imdbId: imdbId) else {
			return completion(.failure(.badUrl))
		}
		
		URLSession.shared.dataTask(with: url) { data, url, error in
			
			guard let data = data, error == nil else {
				return completion(.failure(.noData))
			}
			
			do {
				let detailsMovie = try JSONDecoder().decode(MovieDetailsModel.self, from: data)
				completion(.success(detailsMovie))
				
			}catch {
				print(error)
				completion(.failure(.badDecoding))
				
			}
			
			
		}.resume()
		
		
	}
	
	
	func  getMoviesByName(search: String,completion: @escaping(Result<[MoviesModel]?,NetWorkError>) -> Void ) {
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
				completion(.failure(.badDecoding))
				
				
			}
			
		}.resume()
		
		
	}
	
	
}
