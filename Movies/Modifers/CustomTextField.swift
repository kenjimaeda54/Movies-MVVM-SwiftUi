//
//  CustomTextField.swift
//  Movies
//
//  Created by kenjimaeda on 12/06/23.
//

import Foundation
import SwiftUI

//modificador para o textfield
//aqui estou inserindo padding interno

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
