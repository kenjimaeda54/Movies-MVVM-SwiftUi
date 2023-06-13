//
//  ViewRating.swift
//  Movies
//
//  Created by kenjimaeda on 12/06/23.
//

import SwiftUI

struct ViewRating: View {
	 
	  let rating: Int
	  
	  var notRating: Int {
		    return 10 - rating
		}
	  
	   
	
	  
	
    var body: some View {
			HStack{
				ForEach(0..<rating, id: \.self) { _ in
					   Image(systemName: "star.fill")
						.frame(width: 30,height: 30)
						.foregroundColor(.yellow)
				}
				ForEach(0..<notRating,id: \.self) { _ in
					Image(systemName: "star")
				 .frame(width: 30,height: 30)
				 .foregroundColor(.yellow)
				}
				
			}
    }
}

struct ViewRating_Previews: PreviewProvider {
    static var previews: some View {
        ViewRating(rating: 5)
				.previewLayout(.sizeThatFits)
    }
}
