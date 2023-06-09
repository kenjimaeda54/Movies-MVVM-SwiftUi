//
//  LoadingView.swift
//  Movies
//
//  Created by kenjimaeda on 09/06/23.
//

import SwiftUI

struct LoadingView: View {
	var body: some View {
		ProgressView()
			.progressViewStyle(.circular)
		Spacer()
	}
}

struct LoadingView_Previews: PreviewProvider {
	static var previews: some View {
		LoadingView()
	}
}
