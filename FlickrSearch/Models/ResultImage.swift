//
//  ResultImage.swift
//  FlickrSearch
//
//  Created by Joacim Nidén on 2019-12-07.
//  Copyright © 2019 Joacim Nidén. All rights reserved.
//

import Foundation

struct ResultImage: Codable {
  var imageUrl: String?
  var imageData: Data?
  var imageId: String?
  
  init(_ photo: PhotoAPIModel) {
    imageUrl = FlickrSettings.Route.image(photo).url
    imageData = nil
    imageId = photo.id
  }
}
