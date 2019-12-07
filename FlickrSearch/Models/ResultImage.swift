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
  var imageId: String?
  
  init(_ photo: PhotosAPIModel.Photo) {
    imageUrl = FlickrSettings.Route.details(photo).url
    imageId = photo.id
  }
}
