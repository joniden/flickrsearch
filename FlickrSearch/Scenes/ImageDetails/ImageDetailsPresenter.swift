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
    APIManager.shared.search(<#T##string: String##String#>, callback: <#T##PhotosCallback?##PhotosCallback?##(Result<ResponsePhotosAPIModel, Error>) -> Void#>)
  }
  
}
