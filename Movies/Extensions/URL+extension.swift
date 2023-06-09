//
//  URL+extension.swift
//  Movies
//
//  Created by kenjimaeda on 08/06/23.
//

import Foundation

extension URL {
	
	static func fromMovieByName(name: String) -> URL? {
		 return URL(string: "https://www.omdbapi.com/?i=tt3896198&apikey=\(Constants.apiKey)&s=\(name)")
	}
	
}
