//
//  ViewModelBase.swift
//  Movies
//
//  Created by kenjimaeda on 09/06/23.
//

import Foundation

enum LoadingState {
	
	case none,loading,sucess,failed
	
}


class ViewModelBase: ObservableObject {
	
	@Published var stateLoading: LoadingState = .none
	
}
