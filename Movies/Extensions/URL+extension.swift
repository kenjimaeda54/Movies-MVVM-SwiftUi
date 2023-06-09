//
//  URL+extension.swift
//  Movies
//
//  Created by kenjimaeda on 08/06/23.
//

import Foundation

extension URL {
	
	static func fromMovieDetailsbyImdbId(imdbId: String) -> URL? {
		return URL(string: "https://www.omdbapi.com/?i=\(imdbId)&apikey=\(Constants.apiKey)")
	}
	
	static func fromMovieByName(name: String) -> URL? {
		return URL(string: "https://www.omdbapi.com/?apikey=\(Constants.apiKey)&s=\(name)")
	}
	
}
