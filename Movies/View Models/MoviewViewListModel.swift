//
//  MoviewViewListModel.swift
//  Movies
//
//  Created by kenjimaeda on 08/06/23.
//

import Foundation

class MovieViewListModel: ViewModelBase {
	
	//com @published fico observando a variavel se alterar
	// altera a view
	@Published var moviesView = [MovieViewModel]()
	let httpClient = HttpClient()
	
	func getMoviesByName(_ name: String) {
		
		if(name.isEmpty) {
			return
		}
		
		self.stateLoading = .loading
		
		httpClient.getMoviesByName(search:  String.removeWhiteSpaces(name) ) { result in
			switch result {
				case .failure(let error):
					print(error)
					
					DispatchQueue.main.async {
						self.stateLoading = .failed
					}
					
					
					
				case .success(let movies):
					if let movies = movies {
						
						// por estar lidando com api e recomendado usar dispatchqueue
						DispatchQueue.main.async {
							self.stateLoading = .sucess
							self.moviesView = movies.map(MovieViewModel.init)
							
						}
						
					}
					
			}
		}
		
	}
	
}

struct MovieViewModel {
	
	let movieModel: MoviesModel
	
	var title: String {
		movieModel.title
	}
	
	
	var imdbId: String {
		movieModel.imdbId
	}
	
	
	var poster: String {
		movieModel.poster
	}
	
	var type: String {
		movieModel.type
	}
	
	var year: String {
		movieModel.year
	}
	
	
	
}
