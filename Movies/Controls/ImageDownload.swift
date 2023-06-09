//
//  ImageDownload.swift
//  Movies
//
//  Created by kenjimaeda on 08/06/23.
//

import SwiftUI

struct ImageDownload: View {
	
	@ObservedObject var imageLoader = ImageLoader()
	let url: String
	
	init(url: String) {
		self.url = url
		imageLoader.imageLoader(url: self.url)
	}
	
	var body: some View {
 
			if let data = self.imageLoader.dataImg {
				return Image(uiImage: UIImage(data: data)!)
					.resizable()
			}else {
				return Image("placeholder").resizable()
			}
			
	}
	
}

struct ImageDownload_Previews: PreviewProvider {
	static var previews: some View {
		ImageDownload(url: "https://images.unsplash.com/photo-1685714630051-9d231fb96992?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=437&q=80")
	}
}
