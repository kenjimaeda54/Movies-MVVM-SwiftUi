//
//  MoviesModels.swift
//  Movies
//
//  Created by kenjimaeda on 08/06/23.
//

import Foundation

struct SearchModel: Codable {
	let movies: [MoviesModel]

	//cuidado com a escrita
	//referencia https://medium.com/swiftblade/how-to-choose-properties-to-encode-and-decode-using-codingkeys-2b9b00c6349b
	private enum CodingKeys: String,CodingKey {
		case movies = "Search"
	}
	
}


struct MoviesModel: Codable {
	
	let title: String
	let year: String
	let imdbId: String
	let type: String
	let poster: String
	
	private enum CodingKeys: String, CodingKey {
		case	title = "Title"
		case year = "Year"
		case imdbId = "imdbID"
		case type = "Type"
		case poster = "Poster"
	}
	
	
}
