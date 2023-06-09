//
//  MoviesScreen.swift
//  Movies
//
//  Created by kenjimaeda on 08/06/23.
//

import SwiftUI

struct MoviesScreen: View {
	
	@ObservedObject var movie: MovieViewListModel
	@State private var searchMovie = ""
	
	init(movie: MovieViewListModel) {
		self.movie = movie
	}
	
	func handleCommit()  {
		//onCommit e apos clicar no teclado, se usar o editChange ira a cada letra
		//buscar, é ja que estamos consultado na api e ruim
		movie.getMoviesByName(searchMovie)
	}
	
	
	
	var body: some View {
		NavigationStack {
			
			VStack{
				//			https://www.hackingwithswift.com/quick-start/swiftui/how-to-customize-the-submit-button-for-textfield-securefield-and-texteditor
				// mudar o botão de retorno do keyboard
				TextField("Search...", text: $searchMovie,onCommit: handleCommit)
					.padding(EdgeInsets.init(top: 10, leading: 10, bottom: 10, trailing: 10))
					.textFieldStyle(CustomTextFieldStyle())
					.submitLabel(.go)
				
				
				switch movie.stateLoading {
					case .sucess:
						MovieListView(movies: movie.moviesView)
					case .failed:
						FailedView()
					case .loading:
						LoadingView()
					default:
						Spacer()
				}
				
				
			}
			.navigationTitle("Movies")
			.navigationBarTitleDisplayMode(.inline)
			
			
		}
		
	}
}

struct MoviesScreen_Previews: PreviewProvider {
	static var previews: some View {
		MoviesScreen(movie: MovieViewListModel())
	}
}


struct CustomTextFieldStyle: TextFieldStyle {
	
	public func _body(configuration:  TextField<Self._Label>) -> some View {
		configuration
			.padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
			.background(
				RoundedRectangle(cornerRadius: 5)
					.stroke(
						lineWidth: 1)
					.foregroundColor(Color("blackLigth"))
				
			)
	}
	
	
}
