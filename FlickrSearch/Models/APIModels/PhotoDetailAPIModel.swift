//
//  PhotoDetailAPIModel.swift
//  FlickrSearch
//
//  Created by Joacim Nidén on 2019-12-08.
//  Copyright © 2019 Joacim Nidén. All rights reserved.
//

import Foundation

struct PhotoDetailAPIModel: Codable {
  
  let id: String
  let farm: Int
  let secret: String
  let server: String
  let title: Content?
  let description: Content?
  let dates: Dates?
  
  struct Content: Codable {
    let _content: String
  }
  
  struct Dates: Codable {
    let taken: String?
  }
}
