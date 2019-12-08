//
//  SearchResultViewModel.swift
//  FlickrSearch
//
//  Created by Joacim Nidén on 2019-12-07.
//  Copyright © 2019 Joacim Nidén. All rights reserved.
//

import Foundation

struct SearchResultViewModel {
  let searchString: String
  let photos: [ResultImage]
  let page: Int
  let pages: Int
  
  init(searchString: String, model: PhotosAPIModel) {
    self.searchString = searchString
    if let photos = model.photo {
      self.photos = photos.compactMap { ResultImage($0) }
    } else {
      self.photos = []
    }
    
    page = model.page ?? 0
    pages = model.pages ?? 0
  }
}
