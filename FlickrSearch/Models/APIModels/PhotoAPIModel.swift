//
//  PhotoAPIModel.swift
//  FlickrSearch
//
//  Created by Joacim Nidén on 2019-12-08.
//  Copyright © 2019 Joacim Nidén. All rights reserved.
//

import Foundation

struct PhotoAPIModel: Codable {
  let id: String
  let farm: Int
  let secret: String
  let server: String
}
