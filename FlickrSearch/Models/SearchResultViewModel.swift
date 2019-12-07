//
//  SearchResultViewModel.swift
//  FlickrSearch
//
//  Created by Joacim Nidén on 2019-12-07.
//  Copyright © 2019 Joacim Nidén. All rights reserved.
//

import Foundation

struct SearchResultViewModel: Codable {
  let searchString: String
  let photos: [ResultImage]
}
