//
//  FontLineHeight.swift
//  Movies
//
//  Created by kenjimaeda on 12/06/23.
//

import SwiftUI

//modificador para o tamanho do lineheigth
struct FontWithLineHeight: ViewModifier {
		let font: UIFont
		let lineHeight: CGFloat

		func body(content: Content) -> some View {
				content
						.font(Font(font))
						.lineSpacing(lineHeight - font.lineHeight)
						.padding(.vertical, (lineHeight - font.lineHeight) / 2)
		}
}

extension View {
		func fontWithLineHeight(font: UIFont, lineHeight: CGFloat) -> some View {
				ModifiedContent(content: self, modifier: FontWithLineHeight(font: font, lineHeight: lineHeight))
		}
}
