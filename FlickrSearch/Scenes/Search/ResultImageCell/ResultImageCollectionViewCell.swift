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
	var resultImage: ResultImage? {
		didSet {			
			if let urlString = resultImage?.url {
				url = URL(string: urlString)
			}
		}
	}
	var url: URL?
	var image: UIImage? {
		set {
			imageView?.image = newValue
			resultImage?.image = newValue
		}
		get {
			return imageView?.image
		}
	}
  
  static var identifier: String {
    return String(describing: self)
  }
  
  static var nib: UINib {
    return UINib(nibName: identifier, bundle: nil)
  }
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var imageView: UIImageView?
  @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
  
  // MARK: - Lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    imageView?.contentMode = .scaleAspectFill
    activityIndicatorView.hidesWhenStopped = true
    activityIndicatorView.startAnimating()
  }
  
	func setup(resultImage: ResultImage) {
		self.resultImage = resultImage
  }
  
}
