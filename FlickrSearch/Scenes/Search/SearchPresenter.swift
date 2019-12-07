//
//  SearchPresenter.swift
//  FlickrSearch
//
//  Created by Joacim Nidén on 2019-12-07.
//  Copyright © 2019 Joacim Nidén. All rights reserved.
//

import Foundation

class SearchPresenter {
  
  // MARK: - Vars
  
  private let apiManager = APIManager.shared
  private var ui: SearchViewController?
  
  // MARK: - Life cycle
  
  init(_ ui: SearchViewController) {
    self.ui = ui
  }
  
  // MARK: - Calls
  
  func search(_ string: String) {
    
    guard !string.isEmpty else {
      return
    }
    
    apiManager.search(string) { result in
      DispatchQueue.main.async {
        switch result {
        case .success(let response):
          if let photo = response.photos.photo {
            self.ui?.images = photo.compactMap { ResultImage($0) }
          } else {
            self.ui?.showAlert("no images")
          }
        case .failure(let error):
          self.ui?.showAlert(error.localizedDescription)
        }
      }      
    }
  }
}
