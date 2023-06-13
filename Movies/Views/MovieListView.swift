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
			NavigationLink(destination: MovieDetailsScreen(imdbRating: movie.imdbId)) {
				
				HStack{
					//image url
					//https://www.hackingwithswift.com/quick-start/swiftui/how-to-load-a-remote-image-from-a-url
					//utiliza scale para subsituri o resizeble , quanto maior,menor imagem
					AsyncImage(url: URL(string: movie.poster),scale: 2).scaledToFit().cornerRadius(12)
					
					VStack(alignment: .leading) {
						Spacer(minLength: 20)
						Text(movie.title)
							.font(.system(size: 19,weight: Font.Weight.bold,design: Font.Design.rounded))
							.foregroundColor(Color.black)
			 
						Spacer()
						Text("Year: \(movie.year)")
							.font(.system(size: 16,weight: Font.Weight.medium,design: Font.Design.rounded))
							.foregroundColor(Color.black)
						Spacer(minLength: 20)
					 
					}
					.padding(EdgeInsets.init(top: 0, leading: 10, bottom: 0, trailing: 0))
					
				}
			}
	
			
		}
		.listStyle(.plain)
		.scrollIndicators(.hidden)
		
	}
}

