//
//  ResponsePhotosAPIModel.swift
//  FlickrSearch
//
//  Created by Joacim Nidén on 2019-12-07.
//  Copyright © 2019 Joacim Nidén. All rights reserved.
//

import Foundation

struct ResponsePhotosAPIModel: Codable {
  var photos: PhotosAPIModel
}

struct PhotosAPIModel: Codable {
   
   enum Codingkeys: String, CodingKey {
     case page, pages, total, photo
     case perPage = "perpage"
   }
   
   let page: Int?
   let pages: Int?
   let perPage: Int?
   let total: String?
   let photo: [PhotoAPIModel]?
 }
