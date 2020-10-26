//
//  ResultImage.swift
//  FlickrSearch
//
//  Created by Joacim Nidén on 2019-12-07.
//  Copyright © 2019 Joacim Nidén. All rights reserved.
//

import UIKit

struct ResultImage {
  var url: String?
  var id: String?
	var image: UIImage?
  
  init(_ photo: PhotoAPIModel) {
    url = FlickrSettings.Route.image(photo).url
    id = photo.id
  }
}
