//
//  FailedView.swift
//  Movies
//
//  Created by kenjimaeda on 09/06/23.
//

import SwiftUI

struct FailedView: View {
	var body: some View {
		Image("oops")
			.resizable()
			.scaledToFit()
		Spacer()
	}
}

struct FailedView_Previews: PreviewProvider {
	static var previews: some View {
		FailedView()
	}
}
