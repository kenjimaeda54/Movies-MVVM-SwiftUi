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
- Para mudar o botão do keyboard usamos .submitLabel(.go) no textField


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

##
- Para aumentar o padding interno do TextField usei um modificador




``` swift
//Modiefes
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

//Screens
TextField("Search...", text: $searchMovie,onCommit: handleCommit)
					.padding(EdgeInsets.init(top: 10, leading: 10, bottom: 10, trailing: 10))
					.textFieldStyle(CustomTextFieldStyle()) //usando o modificador
					.submitLabel(.go)




```

##
- Reforcei alguns conceitos como extension.
- Com ele conseguimos extender as propriedades nativas do swift para algo customizado




`` swift
// extension
extension URL {
	
	static func fromMovieDetailsbyImdbId(imdbId: String) -> URL? {
		return URL(string: "https://www.omdbapi.com/?i=\(imdbId)&apikey=\(Constants.apiKey)")
	}
	
	static func fromMovieByName(name: String) -> URL? {
		return URL(string: "https://www.omdbapi.com/?apikey=\(Constants.apiKey)&s=\(name)")
	}
}

// usando extension

guard	let url = URL.fromMovieByName(name: search) else {
			return completion(.failure(.badUrl))
 }
	


```







