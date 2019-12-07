//
//  ResultImageCollectionViewCell.swift
//  FlickrSearch
//
//  Created by Joacim Nidén on 2019-12-07.
//  Copyright © 2019 Joacim Nidén. All rights reserved.
//

import UIKit

class ResultImageCollectionViewCell: UICollectionViewCell {
  
  // MARK: - Vars
  
  static var identifier: String {
    return String(describing: self)
  }
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var imageView: UIImageView!
  
  // MARK: - Lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func setup(_ resultImage: ResultImage) {
    //imageView.image = UIImage(data: )
  }
  
}
