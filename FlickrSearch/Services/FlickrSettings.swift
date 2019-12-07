//
//  FlickrSettings.swift
//  FlickrSearch
//
//  Created by Joacim Nidén on 2019-12-07.
//  Copyright © 2019 Joacim Nidén. All rights reserved.
//

import Foundation

struct FlickrSettings {
  
  private static let apiKey = "433e5318bcd28cc0d4f0b4b5a7ee4b6f"
  private static let baseUrl = "https://www.flickr.com/services/rest/"
  
  /// Doing this route gives a very nice routing structure
  /// This will provide a url route like this `FlickrSettings.search(String)`
  enum Route {
    case search(String)
    case details(PhotosAPIModel.Photo)
    
    var url: String {
      switch self {
      case .search(let searchString):
        return "\(baseUrl)?method=flickr.photos.search&api_key=\(apiKey)&format=json&text=\(searchString)"
      case .details(let photo):
        // This was a neat little method to get a url with only photo information
        return "https://farm\(photo.farm).staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret).jpg"
      }
    }
  }
}
