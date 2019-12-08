//
//  ImageDetailsPresenter.swift
//  FlickrSearch
//
//  Created by Joacim Nidén on 2019-12-08.
//  Copyright © 2019 Joacim Nidén. All rights reserved.
//

import Foundation

class ImageDetailsPresenter {
  
  // MARK: - Vars
  
  var ui: ImageDetailsViewController?
  private let apiManager = APIManager.shared
  
  // MARK: - Init
  
  init(_ ui: ImageDetailsViewController) {
    self.ui = ui
  }
  
  func getDetails(_ photoId: String) {
    apiManager.details(photoId) { result in
      
      DispatchQueue.main.async {
        switch result {
        case .success(let model):
          if let model = model {
            let viewModel = ImageDetailsViewModel(model)
            self.ui?.updateInformation(viewModel)
          }
        case .failure(let error):
          self.ui?.showAlert(error.localizedDescription)
        }
      }
    }
  }
  
}
