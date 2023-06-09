//
//  MoviesScreen.swift
//  Movies
//
//  Created by kenjimaeda on 08/06/23.
//

import SwiftUI

struct MoviesScreen: View {
	
	@ObservedObject var movie: MovieViewListModel
	
	init(movie: MovieViewListModel) {
		self.movie = movie
		movie.getMoviesByName("batman")
	}
	
	var body: some View {
		NavigationStack {
			
			VStack{
				MovieListView(movies: movie.moviesView)
			}
			
			.navigationTitle("Batman")
			
		}
		
	}
}

struct MoviesScreen_Previews: PreviewProvider {
	static var previews: some View {
		MoviesScreen(movie: MovieViewListModel())
	}
}
