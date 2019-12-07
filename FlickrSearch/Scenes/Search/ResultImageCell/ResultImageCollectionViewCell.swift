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
  
  static var nib: UINib {
    return UINib(nibName: identifier, bundle: nil)
  }
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var imageView: UIImageView?
  
  // MARK: - Lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    imageView?.contentMode = .scaleAspectFill
  }
  
  func setup(_ resultImage: ResultImage) {
    
    DispatchQueue.global(qos: .background).async {
      guard let urlString = resultImage.imageUrl,
            let url = URL(string: urlString),
            let data = try? Data(contentsOf: url)
      else {
          return
      }
      
      DispatchQueue.main.async {
        self.imageView?.image = UIImage(data: data)
      }
    }
  }
  
}
