//
//  ImageDetailsViewModel.swift
//  FlickrSearch
//
//  Created by Joacim Nidén on 2019-12-08.
//  Copyright © 2019 Joacim Nidén. All rights reserved.
//

import UIKit

struct ImageDetailsViewModel {
  let title: String
  let attributedText: NSAttributedString
  
  init(_ model: PhotoDetailAPIModel) {
    title = model.title?._content ?? ""
        
    // Description
    let attributedString = NSMutableAttributedString()
    
    attributedString.addTitle("Description")
    attributedString.addBody(model.description?._content ?? "")
    
    // Date
    
    attributedString.addTitle("Taken at date")
    attributedString.addBody(model.dates?.taken ?? "")
      
    attributedText = attributedString
    
  }
}
