//
//  MovieListView.swift
//  Movies
//
//  Created by kenjimaeda on 08/06/23.
//

import SwiftUI

struct MovieListView: View {
	
	var movies: [MovieViewModel]
	
	var body: some View {
		List(movies,id: \.imdbId) { movie in
			ImageDownload(url: movie.poster)
		}
		.listStyle(.plain)
	}
}

