# Movies
Pequena aplicação consumindo uma [API](https://www.omdbapi.com/) de movies, para reforçar aprendizado de MVVM


# Feature
- Arquitetura foi pensando nas boas praticas de MVVM com swiftUI, abaixo um desenho de pastas relacionadas especificas ao MVVM 



```txt

  |Movies
    | Services ==> requisições de API(Rest,GrapqhQl,nativas)
    | Views ==> pequenos pedaços da aplicação semelhante ao Componentes de outros frameworks
    | View Models ==> camada que abstrai a implementação das Screens(Views) e os Models
    | Models ==> onde fica os modelos que usamos para representar nossos dados que consumimos em Views e Views Models
    | Screens ===> tela que e vista em si pelo usuario final

```

##

- Models são os modelos que usamos para consumir em Views Models normalmente sera nossas tipagens para requisiçõers de API,Banco etc
- Abaixo reforçando o uso de CondingKeys
- Observa que preciso mapear todos os parametros dentro do CodingKeys
- Copilador não ira gerar erro se não usar a palavra CondingKeys da maneira correta, porem ao fazer a transformação ira dar erro então tome cuidado

 ```swift
 struct MovieDetailsModel: Codable {
	
	let title: String
	let year: String
	let rated: String
	let plot: String
	let director: String
	let actors: String
	let imdbRating: String
	let poster: String
	let imdbId: String
	
	
	private enum CodingKeys: String, CodingKey {
		case title = "Title"
		case year =  "Year"
		case rated = "Rated"
		case plot =  "Plot"
		case director = "Director"
		case actors = "Actors"
		case poster = "Poster"
		case imdbId = "imdbID"
		case imdbRating. // preciso mapear ela mesmo que não vou transformar
	}
	
	
	
}
 
 
```

##
- Abaixo um uso de uma View Model, primerio implementei abstração para o model que precisava para implementar a View,depois fiz a implementação que de fato a view ira usar


```swift

// Services

enum  NetWorkError: Error {
	case badUrl
	case badDecoding
	case noData
}


class HttpClient {
	
  	
	func  getMoviesByName(search: String,completion: @escaping(Result<[MoviesModel]?,NetWorkError>) -> Void ) {
		guard	let url = URL.fromMovieByName(name: search) else {
			return completion(.failure(.badUrl))
		}
		
		
		URLSession.shared.dataTask(with: url) { data, urlResponse, error in
			
			guard let dataResponse = data, error == nil else {
				return completion(.failure(.noData))
			}
			
			
			do {
				let response = try JSONDecoder().decode(SearchModel.self, from: dataResponse)
				completion(.success(response.movies))
				
			}catch {
				print(error)
				completion(.failure(.badDecoding))
				
				
			}
			
		}.resume()
		
		
	}
  
  
}



// Views Models

class MovieViewListModel: ViewModelBase {

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


// Screens

struct MoviesScreen: View {
	
	@ObservedObject var movie: MovieViewListModel
	@State private var searchMovie = ""
	
	init(movie: MovieViewListModel) {
		self.movie = movie
	}
	
	func handleCommit()  {
		movie.getMoviesByName(searchMovie)
	}
	
	
	
	var body: some View {
		NavigationStack {
			
			VStack{
				TextField("Search...", text: $searchMovie,onCommit: handleCommit)
					.padding(EdgeInsets.init(top: 10, leading: 10, bottom: 10, trailing: 10))
					.textFieldStyle(CustomTextFieldStyle()) //usando o modificador
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




```





