//
//  MovieDetailsViewModel.swift
//  Movies
//
//  Created by kenjimaeda on 12/06/23.
//

import Foundation

class MovieDetailsViewModel: ObservableObject {
	
	var detailsMovieModel: MovieDetailsModel?
	@Published var loading = LoadingState.loading
	var httpClient = HttpClient()
	
	init(detailsMovie: MovieDetailsModel? = nil) {
		self.detailsMovieModel = detailsMovie
	}
	
	
	func getDetailsMovie(_ id: String){
		 
		httpClient.getDetailsMovieByImdbId(imdbId: id) { result in
			   
			switch result {
				case .success(let details):
				
					
					DispatchQueue.main.async {
						self.detailsMovieModel = details
						self.loading = .sucess
					}
					
				case .failure(let error):
				   print(error)
					
					DispatchQueue.main.async {
						self.loading = .failed
					}
			}
			   
		}
				
	}
	
	
	var title:String {
		 detailsMovieModel?.title ?? ""
	}
	
	var year: String {
		 detailsMovieModel?.year ?? ""
	}
	
	var rated: String {
		detailsMovieModel?.rated ?? ""
	}
	

	var plot: String {
		 detailsMovieModel?.plot ?? ""
	}
	
	var director: String {
		 detailsMovieModel?.director ?? ""
	}
	
	var actors: String {
		detailsMovieModel?.actors ?? ""
	}
	
	var imdbRating: Int {
		guard let imdbRating = Double(detailsMovieModel?.imdbRating ?? "0.0") else { return Int(0.0)
			
		}
		return  Int(ceil(imdbRating))
	 
	}
	

	var poster: String {
		detailsMovieModel?.poster ?? " "
	}
	
	var imdbId: String {
		detailsMovieModel?.imdbId ?? ""
	}
	
	
}
