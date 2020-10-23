//
//  SearchPresenter.swift
//  FlickrSearch
//
//  Created by Joacim Nidén on 2019-12-07.
//  Copyright © 2019 Joacim Nidén. All rights reserved.
//

import UIKit

class SearchPresenter {
  
  // MARK: - Vars
  
  private let apiManager = APIManager.shared
  private var ui: SearchViewController?
	
	private let imageProvider = ImageProvider()
  
  // MARK: - Life cycle
  
  init(_ ui: SearchViewController) {
    self.ui = ui
  }
  
  // MARK: - Calls
  
  func search(string: String, page: Int) {
    
    guard !string.isEmpty else {
      return
    }
    
    apiManager.search(string: string, page: page) { result in
      DispatchQueue.main.async {
        switch result {
        case .success(let response):            
          let viewModel = SearchResultViewModel(searchString: string, model: response.photos)
          
          if viewModel.photos.count == 0 {
            self.ui?.showAlert("No results for \"\(string)\"")
          } else {
            self.ui?.updateView(viewModel)
          }          
        case .failure(let error):
          self.ui?.showAlert(error.localizedDescription)
        }
      }      
    }
  }
	
	func getImage(url: URL, completion: @escaping (UIImage) -> Void) {
		imageProvider.loadImage(from: url, completion: completion)
	}
}
