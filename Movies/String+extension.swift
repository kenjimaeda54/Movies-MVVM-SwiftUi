//
//  String+extension.swift
//  Movies
//
//  Created by kenjimaeda on 09/06/23.
//

import Foundation


extension String {
	
	//aqui e para remover os espaços descensarios como Batamna espace espace
	//e tambem permitir espaço na pesquisa como Lord of Kings
	static func removeWhiteSpaces(_ name: String) -> String {
		let stringWithoutWhite = name.trimmingCharacters(in: .whitespacesAndNewlines)
		return stringWithoutWhite.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? name
		
	}
	
}
