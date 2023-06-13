//
//  MovieDetailsScreen.swift
//  Movies
//
//  Created by kenjimaeda on 12/06/23.
//

import SwiftUI

struct MovieDetailsScreen: View {
	  
	let imdbRating: String
	@ObservedObject var movieViewModel = MovieDetailsViewModel()
	

	 
	
    var body: some View {
        
			NavigationStack {
				
				switch movieViewModel.loading {
					case .sucess:
						
						ScrollView {
							MovieDetailsView(detailsMovie: movieViewModel)
						}
				
						 
					case .failed:
						 Spacer()
						 FailedView()
						
					case .loading:
						LoadingView()
					default:
						Spacer()
						
				}
			}
			.navigationTitle(movieViewModel.title)
			.navigationBarTitleDisplayMode(.inline)
			.onAppear(perform: {
		
				self.movieViewModel.getDetailsMovie(imdbRating)
				
			})
			  
			
    }
}

struct MovieDetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsScreen(imdbRating: "10")
    }
}
