//
//  MovieDetailsView.swift
//  Movies
//
//  Created by kenjimaeda on 12/06/23.
//

import SwiftUI

struct MovieDetailsView: View {
	  
	let detailsMovie: MovieDetailsViewModel
	
    var body: some View {
			VStack(spacing: 10) {
				AsyncImage(url: URL(string: detailsMovie.poster),scale: 1).scaledToFit().cornerRadius(12)
				VStack(alignment: HorizontalAlignment.leading, spacing: 5) {
					Text(detailsMovie.title)
						.font(.system(.title))
					Text(detailsMovie.plot)
						.modifier(FontWithLineHeight(font: .systemFont(ofSize: 17, weight: .light, width: .standard), lineHeight: 26)) //usando o modificador
					Text("Director")
						.font(.system(size: 17,weight: .bold, design: .rounded))
					Text(detailsMovie.director)
						.font(.system(size: 17,weight: .regular, design: .rounded))
					
					ViewRating(rating: detailsMovie.imdbRating)
					
				}
				
				
			}
			.padding(EdgeInsets.init(top: 10, leading: 15, bottom: 10, trailing: 15))
			
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
			MovieDetailsView(detailsMovie:  MovieDetailsViewModel(detailsMovie: MovieDetailsModel(title: "Batman Begins", year: "2005", rated:  "PG-13", plot: "After witnessing his parents' death, Bruce learns the art of fighting to confront injustice. When he returns to Gotham as Batman, he must stop a secret society that intends to destroy the city.", director: "Christopher Nolan", actors: "Christian Bale, Michael Caine, Ken Watanabe", imdbRating: "8", poster: "https://m.media-amazon.com/images/M/MV5BOTY4YjI2N2MtYmFlMC00ZjcyLTg3YjEtMDQyM2ZjYzQ5YWFkXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg", imdbId: "3434")))
			
    }
}
