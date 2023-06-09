//
//  ImageLoader.swift
//  Movies
//
//  Created by kenjimaeda on 08/06/23.
//

import Foundation

class ImageLoader: ObservableObject {
	
	@Published var dataImg: Data?
	
	func  imageLoader(url: String)  {
		
		guard  let url = URL(string: url) else {
			print("Error image")
			return
		}
		
		URLSession.shared.dataTask(with: url) { data, _ , error in
		 
				DispatchQueue.main.async {
					self.dataImg = data
				}
			
		}.resume()
		
	}
	
}
